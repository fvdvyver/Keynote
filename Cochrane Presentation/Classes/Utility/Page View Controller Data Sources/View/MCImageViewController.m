//
//  MCImageViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/10.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCImageViewController.h"

@interface MCImageViewController ()

@end

@implementation MCImageViewController

@synthesize image = _image;

- (void)loadView
{
    [super loadView];
    
    if (self.imageView == nil)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        self.imageView = imageView;
        [self.view addSubview:self.imageView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.imageView.image == nil)
    {
        self.imageView.image = self.image;
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

- (UIImage *)image
{
    return _image ?: self.imageView.image;
}

@end
