//
//  CPSResourceListDataProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSResourceListDataProvider <NSObject>

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx;

- (NSString *)titleForSection:(NSInteger)sectionIdx;

- (id)itemAtIndexPath:(NSIndexPath *)indexPath;

- (UIImage *)thumbnailForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
