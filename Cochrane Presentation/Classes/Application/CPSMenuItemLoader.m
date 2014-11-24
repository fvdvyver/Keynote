//
//  CPSMenuItemLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/20.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItemLoader.h"

#import "CPSViewControllerMenuItem.h"
#import "CPSViewControllerContentWireframe.h"

#import "CPSBaseWireframe.h"
#import "CPSKeyValueResourceLoader.h"

@interface CPSMenuItemLoader ()

+ (NSDictionary *)dictionaryFromPlist:(NSString *)filename;

+ (NSArray *)menuItemsFromPlistMenuItems:(NSArray *)plistMenuItems;
+ (CPSViewControllerMenuItem *)menuItemForPlistItem:(NSDictionary *)plistMenuItem;

+ (CPSViewControllerContentWireframe *)wireframeForContentWireframes:(NSArray *)wireframeDescriptions;
+ (NSArray *)viewControllerProvidersForContentWireframes:(NSArray *)wireframeDescriptions;

+ (CPSBaseWireframe *)baseWireframeFromDescription:(NSDictionary *)wireframeDescription;
+ (id)newGenericObjectWithArgumentsFromDictionary:(NSDictionary *)dictionary objectName:(NSString *)name;

+ (void)loadResourcesForInstance:(id)instance withResourceLoaders:(NSArray *)resourceLoaders;
+ (void)loadResourcesForInstance:(id)instance withArguments:(NSDictionary *)args usingClass:(Class)loaderClass;

@end

@implementation CPSMenuItemLoader

+ (NSArray *)loadMenuItemsFromFile:(NSString *)filename
{
    NSDictionary *menuItemDesc = [self dictionaryFromPlist:filename];
    NSArray *plistMenuItems = menuItemDesc[@"menu_items"];
    
    NSAssert([plistMenuItems isKindOfClass:[NSArray class]],
             @"The menu item plist needs a root key of type Array called menu_items");
    
    return [self menuItemsFromPlistMenuItems:plistMenuItems];
}

+ (NSDictionary *)dictionaryFromPlist:(NSString *)filename
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:filepath];
}

+ (NSArray *)menuItemsFromPlistMenuItems:(NSArray *)plistMenuItems
{
    NSMutableArray *menuItems = [NSMutableArray arrayWithCapacity:plistMenuItems.count];
    for (NSDictionary *plistMenuItem in plistMenuItems)
    {
        [menuItems addObject:[self menuItemForPlistItem:plistMenuItem]];
    }
    
    return menuItems;
}

+ (CPSViewControllerMenuItem *)menuItemForPlistItem:(NSDictionary *)plistMenuItem
{
    NSString *title = plistMenuItem[@"title"];
    NSString *iconName = plistMenuItem[@"icon"];
    NSArray *wireframeDescriptions = plistMenuItem[@"content_wireframes"];
    
    NSAssert([title isKindOfClass:[NSString class]], @"Each menu item needs a String title");
    NSAssert([wireframeDescriptions isKindOfClass:[NSArray class]],
             @"Each menu item needs an Array of content_wireframe");
    
    CPSViewControllerContentWireframe *wireframe = [self wireframeForContentWireframes:wireframeDescriptions];
    UIImage *iconImage = (iconName == nil) ? nil : [UIImage imageNamed:iconName];
    
    return [[CPSViewControllerMenuItem alloc] initWithTitle:NSLocalizedString(title, nil)
                                                       icon:iconImage
                                     viewControllerProvider:wireframe];
}

+ (CPSViewControllerContentWireframe *)wireframeForContentWireframes:(NSArray *)wireframeDescriptions
{
    NSArray *providers = [self viewControllerProvidersForContentWireframes:wireframeDescriptions];
    
    CPSViewControllerContentWireframe *wireframe = [CPSViewControllerContentWireframe new];
    wireframe.contentProviders = providers;
    
    for (id provider in providers)
    {
        [self injectContentWireframe:wireframe asParentOfWireframe:provider];
    }
    
    return wireframe;
}

+ (NSArray *)viewControllerProvidersForContentWireframes:(NSArray *)wireframeDescriptions
{
    NSMutableArray *providers = [NSMutableArray arrayWithCapacity:wireframeDescriptions.count];
    
    for (NSDictionary *wireframeDescription in wireframeDescriptions)
    {
        CPSBaseWireframe *wireframe = [self baseWireframeFromDescription:wireframeDescription];
        [providers addObject:wireframe];
    }
    
    return providers;
}

+ (CPSBaseWireframe *)baseWireframeFromDescription:(NSDictionary *)wireframeDescription
{
    NSDictionary *wireframeDict = wireframeDescription[@"wireframe"];
    NSDictionary *interactorDict = wireframeDescription[@"interactor"];
    NSDictionary *presenterDict = wireframeDescription[@"presenter"];
    NSDictionary *viewDict = wireframeDescription[@"view"];
    
    NSAssert([presenterDict isKindOfClass:[NSDictionary class]],
             @"Each content wireframe must have a presenter of type Dictionary");
    NSAssert([viewDict isKindOfClass:[NSDictionary class]],
             @"Each content wireframe must have a view of type Dictionary");
    
    CPSBaseWireframe *wireframe = nil;
    id<CPSInteractor> interactor;
    id<CPSPresenter> presenter = [self newGenericObjectWithArgumentsFromDictionary:presenterDict objectName:@"presenter"];
    if (wireframeDict != nil)
    {
        wireframe = [self newGenericObjectWithArgumentsFromDictionary:wireframeDict objectName:@"wireframe"];
    }
    else
    {
        wireframe = [CPSBaseWireframe new];
    }
    if (interactorDict != nil)
    {
        interactor = [self newGenericObjectWithArgumentsFromDictionary:interactorDict objectName:@"interactor"];
    }
    
    NSString *storyboardName = viewDict[@"storyboard"];
    NSString *viewControllerIdentifier = viewDict[@"identifier"];
    
    NSAssert([wireframe isKindOfClass:[CPSBaseWireframe class]], @"The wireframe must inherit from CPSBaseWireframe");
    NSAssert([presenter conformsToProtocol:@protocol(CPSPresenter)], @"The presenter of a content wireframe must conform to the CPSPresenter protocol");
    NSAssert([viewControllerIdentifier isKindOfClass:[NSString class]], @"The view controller identifier for a content wireframe must be specified as a string");
    
    [presenter setWireframe:wireframe];
    wireframe.presenter = presenter;
    wireframe.storyboardName = storyboardName ?: @"Main";
    wireframe.viewControllerIdentifier = viewControllerIdentifier;
    
    if (interactor != nil)
    {
        wireframe.interactor = interactor;
        
        [interactor setWireframe:wireframe];
        [interactor setPresenter:presenter];
        [presenter setInteractor:interactor];
    }
    
    return wireframe;
}

+ (id)newGenericObjectWithArgumentsFromDictionary:(NSDictionary *)dictionary objectName:(NSString *)name
{
    NSString *objectClass = dictionary[@"class"];
    NSDictionary *objectArgs = dictionary[@"arguments"];
    NSArray *resourceLoaders = dictionary[@"resource_loaders"];
    
    NSMutableArray *mutableResourceLoaders = [NSMutableArray array];
    
    NSAssert([objectClass isKindOfClass:[NSString class]],
             @"The %@ of a content wireframe must have a class name specified as a string", name);
    
    id instance = [NSClassFromString(objectClass) new];
    
    if (objectArgs != nil)
    {
        [mutableResourceLoaders addObject:@{
                                     @"class" : NSStringFromClass([CPSKeyValueResourceLoader class]),
                                     @"arguments" : objectArgs
                                     }];
    }
    if (resourceLoaders != nil)
    {
        NSAssert([resourceLoaders isKindOfClass:[NSArray class]], @"The resource loaders for a %@ should be an array", name);
        [mutableResourceLoaders addObjectsFromArray:resourceLoaders];
    }
    
    [self loadResourcesForInstance:instance withResourceLoaders:mutableResourceLoaders];
    
    return instance;
}

+ (void)loadResourcesForInstance:(id)instance withResourceLoaders:(NSArray *)resourceLoaders
{
    for (NSDictionary *resourceLoader in resourceLoaders)
    {
        NSAssert([resourceLoader isKindOfClass:[NSDictionary class]], @"A resource loader must be specified as a Dictionary");
        
        NSString *loaderClass = resourceLoader[@"class"];
        NSDictionary *loaderArgs = resourceLoader[@"arguments"];
        
        NSAssert([loaderClass isKindOfClass:[NSString class]], @"A resource loader must have a loader class specified");
        
        [self loadResourcesForInstance:instance withArguments:loaderArgs usingClass:NSClassFromString(loaderClass)];
    }
}

+ (void)loadResourcesForInstance:(id)instance withArguments:(NSDictionary *)args usingClass:(Class)loaderClass
{
    CPSResourceLoader *resourceLoader = [loaderClass new];
    resourceLoader.targetObject = instance;
    resourceLoader.arguments = args;
    
    [resourceLoader loadResources];
}

+ (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfWireframe:(id)subwireframe
{
    if ([subwireframe respondsToSelector:@selector(setParentContentWireframe:)])
    {
        [subwireframe setParentContentWireframe:contentWireframe];
    }
}

+ (void)injectContentWireframe:(id<CPSContentWireframe>)contentWireframe asParentOfMenuItems:(NSArray *)menuItems
{
    for (CPSMenuItem *menuItem in menuItems)
    {
        if ([menuItem isKindOfClass:[CPSViewControllerMenuItem class]])
        {
            CPSViewControllerMenuItem *controllerItem = (id)menuItem;
            id provider = [controllerItem viewControllerProvider];
            
            [CPSMenuItemLoader injectContentWireframe:contentWireframe asParentOfWireframe:provider];
        }
    }
}

@end
