//
//  CPSMenuTableViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuTableViewController.h"

#import "CPSMenuItemTableViewCell.h"

@interface CPSMenuTableViewController ()

- (void)configureTableView;
- (void)configureTableViewInsets;
- (void)configureTableViewMask;

@end

@implementation CPSMenuTableViewController

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView registerClass:[CPSMenuItemTableViewCell class]
           forCellReuseIdentifier:[self menuItemCellReuseIdentifier]];
    
    [self configureTableViewInsets];
    [self configureTableViewMask];
}

- (void)configureTableViewInsets
{
    // Configure the table view to be displayed inside the border correctly
    // Never mind the magic numbers. There are no magic numbers. What magic numbers are you talking about?
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top = 50;
    insets.left = 17;
    insets.bottom = 20;
    insets.right = -insets.left;
    
    self.tableView.contentInset = insets;
}

- (void)configureTableViewMask
{
    UIEdgeInsets insets = self.tableView.contentInset;
    
    UIImage *maskImage = [UIImage imageNamed:@"left_border_line_stretch_mask"];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    maskLayer.frame = CGRectMake(-insets.left, 0, maskImage.size.width, maskImage.size.height);
    maskLayer.contents = (id)maskImage.CGImage;
    maskLayer.actions = @{
                          @"onOrderIn" : [NSNull null],
                          @"onOrderOut" : [NSNull null],
                          @"sublayers" : [NSNull null],
                          @"contents" : [NSNull null],
                          @"bounds" : [NSNull null],
                          @"position" : [NSNull null]
                          };
    
    CGFloat stretchHeight = maskImage.size.height - maskImage.capInsets.bottom - maskImage.capInsets.top;
    maskLayer.contentsCenter = CGRectMake(0.0,
                                          maskLayer.contentsScale * maskImage.capInsets.top / maskImage.size.width,
                                          1.0,
                                          maskLayer.contentsScale * stretchHeight / maskImage.size.height);
    
    self.tableView.layer.mask = maskLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureTableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CALayer *maskLayer = self.tableView.layer.mask;
    CGRect maskFrame = maskLayer.frame;
    
    maskFrame.size.height = CGRectGetHeight(self.tableView.bounds);
    
    maskLayer.frame = maskFrame;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.tableView.dataSource == nil)
    {
        [self.eventHandler updateDatasource];
    }
    [self.eventHandler updateSelection];
}

- (void)setSelectedIndexPath:(NSIndexPath *)indexPath
{
    BOOL animate = [self isViewLoaded];
    [self.tableView selectRowAtIndexPath:indexPath animated:animate scrollPosition:UITableViewScrollPositionNone];
}

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource
{
    [self.tableView setDataSource:datasource];
}

- (void)setTableViewDelegate:(id<UITableViewDelegate>)delegate
{
    [self.tableView setDelegate:delegate];
}

- (NSString *)menuItemCellReuseIdentifier
{
    return @"menu_item_cell";
}

@end
