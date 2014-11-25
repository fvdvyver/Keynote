//
//  MCTableViewDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCTableViewDelegate.h"

@implementation MCTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.eventHandler tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
