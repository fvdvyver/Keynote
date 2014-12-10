//
//  CPSClearVuTableViewDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSClearVuTableViewDelegate.h"

#import "CPSAssetItem.h"

@implementation CPSClearVuTableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPSAssetItem *item = self.items[indexPath.row];
    if (item.secondaryFilename.length > 0)
    {
        // Item has animation video
        // This value ensures the cell is big enough for the video, and also that it aligns with the intro video
        return 144.0;
    }
    else
    {
        // Just text
        return 50.0;
    }
}

@end
