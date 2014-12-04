//
//  CPSAccessPageViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSLoadingViewController.h"

#import "CPSView.h"
#import "CPSAccessPageInterface.h"

@interface CPSAccessPageViewController : CPSLoadingViewController <CPSView>

@property (nonatomic, weak) id<CPSAccessPageEventHandler> eventHandler;

- (IBAction)accessButtonTapped:(id)sender;

@end
