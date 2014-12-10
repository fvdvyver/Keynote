//
//  CPSClearVuVideoListViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSClearVuVideoListViewController.h"

#import "UITableView+CPSMaskingAdditions.h"
#import "CALayer+CPSImplicitActionRemoval.h"

@interface CPSClearVuVideoListViewController ()

- (void)configureTableView;
- (void)configureContentVideoContainerView;

@end

@implementation CPSClearVuVideoListViewController

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    
    [self.tableView cps_configureTableViewMaskWithImage:[UITableView cps_maskImageNameForClearVuTable]
                                                 insets:[UITableView cps_insetsForClearVuTableMask]];
}

- (void)configureContentVideoContainerView
{
    UIImage *maskImage = [UIImage imageNamed:@"clearvu_video_mask"];
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
    
    [self configureTableView];
    [self configureContentVideoContainerView];
}

@end
