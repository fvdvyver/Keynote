//
//  CPSKeyIndustriesGridViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSKeyIndustriesViewInterface.h"

@interface CPSKeyIndustriesGridViewController : UIViewController <CPSKeyIndustriesView>

@property (nonatomic, weak) id<CPSKeyIndustriesViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UICollectionView * collectionView;

@end
