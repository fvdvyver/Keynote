//
//  CPSImagePagerViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSImagePagerView.h"

@interface CPSImagePagerViewController : UIViewController <CPSImagePagerView>

@property (nonatomic, weak) id<CPSImagePagerViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UIImageView * backgroundImageView;

@property (nonatomic, weak) IBOutlet UILabel * titleLabel;
@property (nonatomic, weak) IBOutlet UIView *  pagerContainerView;

@property (nonatomic, strong) IBInspectable NSString * pageViewControllerEmbedSegueIdentifier;

@property (nonatomic, weak, readonly) UIPageViewController * pageViewController;

@property (nonatomic, assign) BOOL backgroundVisible;
@property (nonatomic, assign) NSUInteger imageIndex;

@end
