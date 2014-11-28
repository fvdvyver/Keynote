//
//  CPSKeyIndustriesItemDatasource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesItemDatasource.h"

#import "CPSAssetItem.h"

@implementation CPSKeyIndustriesItemDatasource

- (NSString *)titleForItem:(CPSAssetItem *)item
{
    return item.title;
}

- (UIImage *)iconForItem:(CPSAssetItem *)item
{
    UIImage *image = [UIImage imageNamed:item.primaryFilename];
    if (image == nil)
    {
        NSLog(@"WARNING: Image (%@) for key industries item '%@' could not be found",
              item.primaryFilename, item.title);
    }
    return image;
}

@end
