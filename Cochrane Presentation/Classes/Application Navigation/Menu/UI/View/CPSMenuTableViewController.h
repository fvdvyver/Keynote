//
//  CPSMenuTableViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSMenuViewInterface.h"

@interface CPSMenuTableViewController : UITableViewController <CPSMenuViewInterface>

@property (nonatomic, weak) id<CPSMenuViewEventHandler> eventHandler;

@end
