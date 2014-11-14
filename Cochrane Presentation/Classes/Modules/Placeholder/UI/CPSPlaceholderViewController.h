//
//  CPSPlaceholderViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSPlaceholderViewInterface.h"

@interface CPSPlaceholderViewController : UIViewController <CPSPlaceholderViewInterface>

@property (nonatomic, weak) id<CPSPlaceholderViewEventHandler> eventHandler;

@end
