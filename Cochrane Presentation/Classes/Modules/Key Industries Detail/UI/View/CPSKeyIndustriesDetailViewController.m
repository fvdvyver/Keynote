//
//  CPSKeyIndustriesDetailViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesDetailViewController.h"

#import "MCImageArrayPagerDataSource.h"

#define kPageViewControllerEmbedSegueIdentifier @"PageControllerEmbed"

@interface CPSKeyIndustriesDetailViewController ()

@property (nonatomic, weak, readwrite) UIPageViewController * pageViewController;
@property (nonatomic, strong) MCImageArrayPagerDataSource *   pagerDataSource;

- (void)setupImageClippingMask;
- (void)setupGestureRecognizers;

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation CPSKeyIndustriesDetailViewController

- (void)setupImageClippingMask
{
    CALayer *imageMask = [CALayer layer];
    imageMask.contents = (id)[UIImage imageNamed:@"key_industry_image_clipping_mask"].CGImage;
    
    self.pagerContainerView.layer.mask = imageMask;
}

- (void)setupGestureRecognizers
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupImageClippingMask];
    [self setupGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.pagerContainerView.layer.mask.frame = self.pagerContainerView.bounds;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setImageNames:(NSArray *)imageNames
{
    MCImageArrayPagerDataSource *pagerDatasource = [MCImageArrayPagerDataSource new];
    pagerDatasource.imageNames = imageNames;
    
    self.pagerDataSource = pagerDatasource;
    self.pageViewController.dataSource = self.pagerDataSource;
    
    if (imageNames.count > 0)
    {
        [self.pageViewController setViewControllers:@[ [self.pagerDataSource viewControllerForImageAtIndex:0] ]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:[self isViewLoaded]
                                         completion:nil];
    }
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewTapped];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kPageViewControllerEmbedSegueIdentifier])
    {
        self.pageViewController = (id)segue.destinationViewController;
        if (self.pageViewController.dataSource == nil)
        {
            self.pageViewController.dataSource = self.pagerDataSource;
        }
    }
}

@end
