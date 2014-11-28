//
//  CPSKeyIndustriesItemDatasource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustriesViewInterface.h"

@class CPSAssetItem;

@interface CPSKeyIndustriesItemDatasource : NSObject <CPSKeyIndustriesItemDataProvider>

@property (nonatomic, strong) NSArray * items;

- (NSString *)titleForItem:(CPSAssetItem *)item;
- (UIImage *)iconForItem:(CPSAssetItem *)item;

@end
