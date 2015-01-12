//
//  CPSVideoListEmbeddedContentViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListViewController.h"

#import "CPSVideoListResourceView.h"

@interface CPSVideoListEmbeddedContentViewController : CPSVideoListViewController <CPSVideoListResourceView>

@property (nonatomic, weak) id<CPSVideoListResourceViewEventHandler> eventHandler;

@property (nonatomic, strong) IBOutlet UIButton * additionalResourceButton;

@property (nonatomic, readonly) UIViewController * contentViewController;

- (IBAction)additionalResourceButtonTapped:(UIButton *)sender;

@end
