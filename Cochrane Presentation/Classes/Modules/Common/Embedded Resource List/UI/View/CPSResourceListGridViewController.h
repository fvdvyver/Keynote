//
//  CPSResourceListGridViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSResourceListView.h"

@interface CPSResourceListGridViewController : UIViewController <CPSResourceListView>

@property (nonatomic, weak) id<CPSResourceListViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic, weak) IBOutlet UIImageView * backgroundImageView;

@property (nonatomic, assign) IBInspectable UIEdgeInsets collectionViewInsets;

@end
