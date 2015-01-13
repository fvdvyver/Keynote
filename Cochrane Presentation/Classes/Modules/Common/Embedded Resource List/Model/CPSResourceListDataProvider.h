//
//  CPSResourceListDataProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSFileAssetType.h"

@protocol CPSResourceListDataProvider <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx;

- (id)sectionDataForSectionAtIndex:(NSInteger)sectionIdx;
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (id)titleForSectionData:(id)sectionData;

- (NSString *)assetPathForItem:(id)item outType:(CPSFileAssetType *)type;
- (NSString *)titleForItem:(id)item;

@end
