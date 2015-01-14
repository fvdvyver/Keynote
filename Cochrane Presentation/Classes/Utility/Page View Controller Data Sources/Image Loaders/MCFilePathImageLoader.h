//
//  MCFilePathImageLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCImageLoader.h"

@interface MCFilePathImageLoader : NSObject <MCImageLoader>

@property (nonatomic, strong) NSString * filePath;

+ (instancetype)loaderWithFilePath:(NSString *)filePath;
+ (NSArray *)loadersWithFilePaths:(NSArray *)filePaths;

@end
