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

@end

@implementation CPSPlaceholderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.eventHandler updateView];
}

- (void)setPlacholderText:(NSString *)placeholderText
{
    [self.placeholderLabel setText:placeholderText];
}

@end
