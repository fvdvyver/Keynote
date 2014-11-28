//
//  CPSKeyIndustriesDetailViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesDetailViewController.h"

@interface CPSKeyIndustriesDetailViewController ()

- (void)setupGestureRecognizers;

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer;

@end

@implementation CPSKeyIndustriesDetailViewController

- (void)setupGestureRecognizers
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupGestureRecognizers];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.eventHandler updateView];
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)viewTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewTapped];
}

@end
