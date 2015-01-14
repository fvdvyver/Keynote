//
//  MCNamedImageLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCNamedImageLoader.h"

@implementation MCNamedImageLoader

+ (instancetype)loaderWithImageName:(NSString *)imageName
{
    MCNamedImageLoader *loader = [[self class] new];
    loader.imageName = imageName;
    
    return loader;
}

+ (NSArray *)loadersWithImageNames:(NSArray *)imageNames
{
    NSMutableArray *imageLoaders = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (NSString *path in imageNames)
    {
        [imageLoaders addObject:[MCNamedImageLoader loaderWithImageName:path]];
    }
    
    return [NSArray arrayWithArray:imageLoaders];
}

- (UIImage *)loadImage
{
    return [UIImage imageNamed:self.imageName];
}

@end
