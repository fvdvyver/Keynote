//
//  MCCollectionViewSectionDataProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MCCollectionViewSectionDataProvider <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx;

- (id)sectionDataForIndexPath:(NSIndexPath *)indexPath;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
