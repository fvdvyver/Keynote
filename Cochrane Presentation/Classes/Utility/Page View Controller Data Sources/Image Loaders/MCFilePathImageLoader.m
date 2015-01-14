//
//  MCFilePathImageLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCFilePathImageLoader.h"

@implementation MCFilePathImageLoader

+ (instancetype)loaderWithFilePath:(NSString *)filePath
{
    MCFilePathImageLoader *loader = [[self class] new];
    loader.filePath = filePath;
    
    return loader;
}

+ (NSArray *)loadersWithFilePaths:(NSArray *)filePaths
{
    NSMutableArray *imageLoaders = [NSMutableArray arrayWithCapacity:filePaths.count];
    for (NSString *path in filePaths)
    {
        [imageLoaders addObject:[MCFilePathImageLoader loaderWithFilePath:path]];
    }
    
    return [NSArray arrayWithArray:imageLoaders];
}

- (UIImage *)loadImage
{
    return [UIImage imageWithContentsOfFile:self.filePath];
}

@end
