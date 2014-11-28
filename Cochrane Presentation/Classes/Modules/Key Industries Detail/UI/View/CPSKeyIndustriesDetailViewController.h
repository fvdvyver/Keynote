//
//  CPSKeyIndustriesDetailViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSKeyIndustriesDetailViewInterface.h"

@interface CPSKeyIndustriesDetailViewController : UIViewController <CPSKeyIndustriesDetailView>

@property (nonatomic, weak) id<CPSKeyIndustriesDetailViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
