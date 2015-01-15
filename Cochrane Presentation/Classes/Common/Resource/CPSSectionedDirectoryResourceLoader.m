//
//  CPSSectionedDirectoryResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSSectionedDirectoryResourceLoader.h"

#import "CPSFileAssetItem.h"
#import "CPSResourceDirectory.h"

#import "NSFileManager+CPSResourceDirectoryAdditions.h"

@interface CPSSectionedDirectoryResourceLoader ()

@property (nonatomic, strong) NSString * pathPrefix;
@property (nonatomic, strong) NSString * sectionedDataKeypath;

@end

@implementation CPSSectionedDirectoryResourceLoader

- (void)loadResources
{
    NSString *pathPrefix = self.arguments[@"resource_path_prefix"];
    NSString *keypath = self.arguments[@"sectioned_data_keypath"];
    
    NSAssert(pathPrefix != nil, @"%@ needs a valid path prefix to load the directories from",
             NSStringFromClass(self.class));
    NSAssert(keypath != nil, @"%@ needs a valid path keypath to assign the sectioned resource data to",
             NSStringFromClass(self.class));
    
    self.pathPrefix = pathPrefix;
    self.sectionedDataKeypath = keypath;
    
    [super loadResources];
}

- (id)newMappedItemFromSource:(NSDictionary *)sourceItem
             destinationClass:(Class)destinationClass
                  withMapping:(NSDictionary *)itemMapping
{
    id item = [super newMappedItemFromSource:sourceItem destinationClass:destinationClass withMapping:itemMapping];
    NSDictionary *resource = sourceItem[@"resource"];
    if (resource != nil)
    {
        [self loadSectionedResourcesForTargetItem:item resourceSpecification:resource];
    }
    
    return item;
}

- (void)loadSectionedResourcesForTargetItem:(id)target
                      resourceSpecification:(NSDictionary *)resource
{
    NSString *directory = resource[@"directory"];
    NSArray *sections = resource[@"sections"];
    
    NSAssert(directory != nil, @"%@: The resource specification dictionary needs a directory specified",
             NSStringFromClass(self.class));
    NSAssert(sections ==  nil || [sections isKindOfClass:[NSArray class]],
             @"%@: The resources specification dictionary sections must be an array", NSStringFromClass(self.class));
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *resourcePath = [bundlePath stringByAppendingPathComponent:self.pathPrefix];
    resourcePath = [resourcePath stringByAppendingPathComponent:directory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSMutableArray *loadedSections = [NSMutableArray arrayWithCapacity:sections.count];
    for (NSString *section in sections)
    {
        NSString *sectionPath = [resourcePath stringByAppendingPathComponent:section];
        
        BOOL isDir = NO;
        if ([fileManager fileExistsAtPath:sectionPath isDirectory:&isDir] && isDir)
        {
            CPSResourceDirectory *directory = [fileManager loadResourcesAtDirectory:sectionPath];
            if (directory != nil)
            {
                [loadedSections addObject:directory];
            }
        }
        else
        {
            NSLog(@"%@. Warning: Resource section specified at path %@ does not exist or is not a folder",
                  NSStringFromClass(self.class), sectionPath);
        }
    }
    
    if (loadedSections.count > 0)
    {
        [target setValue:loadedSections forKeyPath:self.sectionedDataKeypath];
    }
}

@end
