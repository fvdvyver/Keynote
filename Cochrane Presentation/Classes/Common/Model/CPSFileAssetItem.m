//
//  CPSFileAssetItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSFileAssetItem.h"

@interface CPSFileAssetItem ()

@property (nonatomic, strong) NSString * filePath;

@end

@implementation CPSFileAssetItem

+ (instancetype)itemWithPath:(NSString *)path
{
    CPSFileAssetItem *item = [[self class] new];
    item.filePath = path;
    
    return item;
}

- (NSString *)path
{
    return _filePath;
}

@end
