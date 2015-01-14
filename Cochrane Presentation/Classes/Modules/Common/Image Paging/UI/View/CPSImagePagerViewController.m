//
//  CPSImagePagerViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSImagePagerViewController.h"

#import "MCImageArrayPagerDataSource.h"

@interface CPSImagePagerViewController ()

@property (nonatomic, weak, readwrite) UIPageViewController * pageViewController;
@property (nonatomic, strong) MCImageArrayPagerDataSource *   pagerDataSource;

@property (nonatomic, strong) CAGradientLayer * textBackgroundLayer;

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer;

- (void)setupImageClippingMask;
- (void)setupTextBackgroundLayer;
- (void)setupGestureRecognizers;

@end

@implementation CPSImagePagerViewController

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
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupImageClippingMask];
    [self setupTextBackgroundLayer];
    [self setupGestureRecognizers];
    
    self.backgroundImageView.hidden = !self.backgroundVisible;
    self.view.backgroundColor = self.backgroundVisible ? [UIColor blackColor] : [UIColor clearColor];
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

- (void)setImageIndex:(NSUInteger)imageIndex
{
    _imageIndex = imageIndex;
    
    if (self.pagerDataSource != nil && self.pageViewController != nil)
    {
        UIViewController *controller = [self.pagerDataSource viewControllerForImageAtIndex:self.imageIndex];
        [self.pageViewController setViewControllers:@[ controller ]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:[self isViewLoaded]
                                         completion:nil];
    }
}

- (void)setImageLoaders:(NSArray *)imageLoaders
{
    MCImageArrayPagerDataSource *pagerDatasource = [MCImageArrayPagerDataSource new];
    pagerDatasource.imageLoaders = imageLoaders;
    
    self.pagerDataSource = pagerDatasource;
    self.pageViewController.dataSource = self.pagerDataSource;
    
    if (imageLoaders.count > 0 && self.pageViewController != nil)
    {
        UIViewController *controller = [self.pagerDataSource viewControllerForImageAtIndex:self.imageIndex];
        [self.pageViewController setViewControllers:@[ controller ]
                                          direction:UIPageViewControllerNavigationDirectionForward
                                           animated:[self isViewLoaded]
                                         completion:nil];
    }
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewTapped];
}

- (void)setBackgroundVisible:(BOOL)visible
{
    _backgroundVisible = visible;
    
    if ([self isViewLoaded])
    {
        self.backgroundImageView.hidden = !self.backgroundVisible;
        self.view.backgroundColor = self.backgroundVisible ? [UIColor blackColor] : [UIColor clearColor];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:self.pageViewControllerEmbedSegueIdentifier])
    {
        self.pageViewController = (id)segue.destinationViewController;
        if (self.pageViewController.dataSource == nil)
        {
            self.pageViewController.dataSource = self.pagerDataSource;
        }
    }
}

@end
