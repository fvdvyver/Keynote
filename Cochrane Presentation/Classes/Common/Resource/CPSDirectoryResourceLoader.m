//
//  CPSDirectoryResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/22.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSDirectoryResourceLoader.h"

#import "NSFileManager+CPSResourceDirectoryAdditions.h"

@interface CPSDirectoryResourceLoader ()

@property (nonatomic, strong) NSString * pathPrefix;
@property (nonatomic, strong) NSString * dataListKeypath;

@end

@implementation CPSDirectoryResourceLoader

- (void)loadResources
{
    NSString *pathPrefix = self.arguments[@"resource_path_prefix"];
    NSString *keypath = self.arguments[@"resource_data_list_keypath"];
    
    NSAssert(pathPrefix != nil, @"%@ needs a valid path prefix to load the directories from",
             NSStringFromClass(self.class));
    NSAssert(keypath != nil, @"%@ needs a valid path keypath to assign the resource data to",
             NSStringFromClass(self.class));
    
    self.pathPrefix = pathPrefix;
    self.dataListKeypath = keypath;
    
    [super loadResources];
}

- (id)newMappedItemFromSource:(NSDictionary *)sourceItem
             destinationClass:(Class)destinationClass
                  withMapping:(NSDictionary *)itemMapping
{
    id item = [super newMappedItemFromSource:sourceItem destinationClass:destinationClass withMapping:itemMapping];
    NSString *directory = sourceItem[@"directory"];
    if (directory != nil)
    {
        [self loadSectionedResourcesForTargetItem:item inDirectory:directory];
    }
    
    return item;
}

- (void)loadSectionedResourcesForTargetItem:(id)target
                                inDirectory:(NSString *)directory
{
    NSAssert(directory != nil, @"%@: The resource specification dictionary needs a directory specified",
             NSStringFromClass(self.class));
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *resourcePath = [bundlePath stringByAppendingPathComponent:self.pathPrefix];
    resourcePath = [resourcePath stringByAppendingPathComponent:directory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *filePaths = [fileManager filePathsOfNonDirectoriesAtPath:resourcePath];
    
    if (filePaths.count > 0)
    {
        [target setValue:filePaths forKeyPath:self.dataListKeypath];
    }
    else
    {
        NSLog(@"Warning(%@): resource directory contents empty at path %@", NSStringFromClass(self.class), resourcePath);
    }
}

@end
