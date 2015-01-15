//
//  CPSResourceListDirectoryResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceListDirectoryResourceLoader.h"

#import "NSFileManager+CPSResourceDirectoryAdditions.h"

@implementation CPSResourceListDirectoryResourceLoader

- (void)loadResources
{
    NSString *baseDirectory = self.arguments[@"base_directory"];
    NSString *targetDataKeypath = self.arguments[@"target_data_keypath"];
    
    NSAssert(baseDirectory != nil,
             @"%@ needs the base directory of resource that must be enumerated", NSStringFromClass(self.class));
    NSAssert(targetDataKeypath != nil,
             @"%@ needs the key path of the parsed data array on the target object to be set", NSStringFromClass(self.class));
    
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSString *resourcePath = [bundlePath stringByAppendingPathComponent:baseDirectory];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *resources = [fileManager loadSectionedResourcesAtDirectory:resourcePath];
    
    [self.targetObject setValue:resources forKey:targetDataKeypath];
}

@end
