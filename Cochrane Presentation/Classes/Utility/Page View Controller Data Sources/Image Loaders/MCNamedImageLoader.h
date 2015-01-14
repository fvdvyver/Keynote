//
//  MCNamedImageLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCImageLoader.h"

@interface MCNamedImageLoader : NSObject <MCImageLoader>

@property (nonatomic, strong) NSString * imageName;

+ (instancetype)loaderWithImageName:(NSString *)imageName;
+ (NSArray *)loadersWithImageNames:(NSArray *)imageNames;

@end
