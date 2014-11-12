//
//  CPSMenuItemTableViewDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSMenuItemTableViewEventHandler;

@interface CPSMenuItemTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, weak) id<CPSMenuItemTableViewEventHandler> eventHandler;

@end

@protocol CPSMenuItemTableViewEventHandler <NSObject>

- (void)menuItemSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end
