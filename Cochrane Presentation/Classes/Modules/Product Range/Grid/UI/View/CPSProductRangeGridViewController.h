//
//  CPSProductRangeGridViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSProductRangeListViewInterface.h"

@interface CPSProductRangeGridViewController : UIViewController <CPSProductRangeListView>

@property (nonatomic, weak) id<CPSProductRangeListViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;

@end
