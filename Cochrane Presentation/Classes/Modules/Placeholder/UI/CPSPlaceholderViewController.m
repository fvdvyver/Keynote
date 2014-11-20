//
//  CPSPlaceholderViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPlaceholderViewController.h"

@interface CPSPlaceholderViewController ()

@property (nonatomic, weak) IBOutlet UILabel *placeholderLabel;

- (void)setupGestureRecognizer;

- (void)viewDoubleTapped:(UIGestureRecognizer *)gestureRecognizer;

@end

@implementation CPSPlaceholderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.eventHandler updateView];
    [self setupGestureRecognizer];
}

- (void)setupGestureRecognizer
{
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(viewDoubleTapped:)];
    recognizer.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:recognizer];
}

- (void)setPlacholderText:(NSString *)placeholderText
{
    [self.placeholderLabel setText:placeholderText];
}

- (void)viewDoubleTapped:(UIGestureRecognizer *)gestureRecognizer
{
    [self.eventHandler viewDoubleTapped];
}

@end
