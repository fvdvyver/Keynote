//
//  CPSFileAssetItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSFileAssetItem : NSObject

@property (nonatomic, readonly) NSString * path;

+ (instancetype)itemWithPath:(NSString *)path;

@end
