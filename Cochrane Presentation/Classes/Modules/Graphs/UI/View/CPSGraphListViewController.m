//
//  CPSGraphListViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSGraphListViewController.h"

#import "CALayer+CPSImplicitActionRemoval.h"

@interface CPSGraphListViewController ()

@end

@implementation CPSGraphListViewController

- (void)configureContentVideoContainerView
{
    UIImage *maskImage = [UIImage imageNamed:@"graphs_video_mask"];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    maskLayer.frame = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    maskLayer.contents = (id)maskImage.CGImage;
    [maskLayer cps_removeImplicitActions];
    
    self.contentVideoContainerView.layer.mask = maskLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureContentVideoContainerView];
}

@end
