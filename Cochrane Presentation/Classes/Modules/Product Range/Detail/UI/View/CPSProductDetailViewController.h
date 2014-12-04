//
//  CPSProductDetailViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/03.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSProductDetailViewInterface.h"

@interface CPSProductDetailViewController : UIViewController <CPSProductDetailView>

@property (nonatomic, weak) id<CPSProductDetailViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UIView *  videoContainerView;
@property (nonatomic, weak) IBOutlet UILabel * titleLabel;

@end
