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

@property (nonatomic, strong) CAGradientLayer * textBackgroundLayer;

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

- (void)setupTextBackgroundLayer
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0.5, 0.0);
    layer.endPoint = CGPointMake(0.5, 1.0);
    layer.locations = @[ @0.0, @0.1 ];
    layer.colors = @[
                     (__bridge id)[UIColor clearColor].CGColor,
                      (__bridge id)[UIColor colorWithWhite:0.0 alpha:0.5].CGColor
                      ];
    
    [self.view.layer addSublayer:layer];
    [self.view bringSubviewToFront:self.titleLabel];
    self.textBackgroundLayer = layer;
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
    [self setupTextBackgroundLayer];
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
    
    CGRect titleFrame = self.titleLabel.frame;
    const CGFloat dh = 10;
    
    self.pagerContainerView.layer.mask.frame = self.pagerContainerView.bounds;
    
    titleFrame.origin.y -= dh;
    titleFrame.size.height += dh;

    self.textBackgroundLayer.frame = titleFrame;
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
