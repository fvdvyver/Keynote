//
//  CPSMenuItemTableViewDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItemTableViewDelegate.h"

@implementation CPSMenuItemTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.eventHandler menuItemSelectedAtIndexPath:indexPath];
}

@end
