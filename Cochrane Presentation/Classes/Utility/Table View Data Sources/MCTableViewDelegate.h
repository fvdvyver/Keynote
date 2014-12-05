//
//  MCTableViewDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCTableViewDelegateEventHandler;

@interface MCTableViewDelegate : NSObject <UITableViewDelegate>

@property (nonatomic, weak) id<MCTableViewDelegateEventHandler> eventHandler;

@end

@protocol MCTableViewDelegateEventHandler <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
