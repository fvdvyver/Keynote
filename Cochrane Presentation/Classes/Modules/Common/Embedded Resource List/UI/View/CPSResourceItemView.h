//
//  CPSResourceItemView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSFileAssetType.h"

@protocol CPSResourceItemView <NSObject>

- (void)setTitle:(NSString *)title;
- (void)setImage:(UIImage *)image;
- (void)setAssetPath:(NSString *)assetPath type:(CPSFileAssetType)type;

@end

@protocol CPSResourceListHeaderView <NSObject>

- (void)setTitle:(NSString *)title;

@end
