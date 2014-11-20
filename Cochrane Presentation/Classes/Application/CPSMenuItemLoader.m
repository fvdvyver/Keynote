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

@interface CPSMenuItemLoader ()

+ (NSDictionary *)dictionaryFromPlist:(NSString *)filename;

+ (NSArray *)menuItemsFromPlistMenuItems:(NSArray *)plistMenuItems;
+ (CPSViewControllerMenuItem *)menuItemForPlistItem:(NSDictionary *)plistMenuItem;

+ (CPSViewControllerContentWireframe *)wireframeForContentWireframes:(NSArray *)wireframeDescriptions;
+ (NSArray *)viewControllerProvidersForContentWireframes:(NSArray *)wireframeDescriptions;

+ (CPSBaseWireframe *)baseWireframeFromDescription:(NSDictionary *)wireframeDescription;
+ (id)newGenericObjectWithArgumentsFromDictionary:(NSDictionary *)dictionary objectName:(NSString *)name;

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
    NSDictionary *presenterDict = wireframeDescription[@"presenter"];
    NSDictionary *viewDict = wireframeDescription[@"view"];
    
    NSAssert([presenterDict isKindOfClass:[NSDictionary class]],
             @"Each content wireframe must have a presenter of type Dictionary");
    NSAssert([viewDict isKindOfClass:[NSDictionary class]],
             @"Each content wireframe must have a view of type Dictionary");
    
    CPSBaseWireframe *wireframe = nil;
    id<CPSPresenter> presenter = [self newGenericObjectWithArgumentsFromDictionary:presenterDict objectName:@"presenter"];
    if (wireframeDict != nil)
    {
        wireframe = [self newGenericObjectWithArgumentsFromDictionary:wireframeDict objectName:@"wireframe"];
    }
    else
    {
        wireframe = [CPSBaseWireframe new];
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
    
    return wireframe;
}

+ (id)newGenericObjectWithArgumentsFromDictionary:(NSDictionary *)dictionary objectName:(NSString *)name
{
    NSString *objectClass = dictionary[@"class"];
    NSDictionary *objectArgs = dictionary[@"arguments"];
    
    NSAssert([objectClass isKindOfClass:[NSString class]],
             @"The %@ of a content wireframe must have a class name specified as a string", name);
    
    id instance = [NSClassFromString(objectClass) new];
    if (objectArgs != nil)
    {
        for (NSString *key in [objectArgs allKeys])
        {
            id value = objectArgs[key];
            [instance setValue:value forKey:key];
        }
    }
    
    return instance;
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
