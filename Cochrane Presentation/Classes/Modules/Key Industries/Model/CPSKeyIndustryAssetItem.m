//
//  CPSKeyIndustryAssetItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/09.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustryAssetItem.h"

@interface CPSKeyIndustryAssetItem ()

- (void)loadImageArrayFromPlist;

@end

@implementation CPSKeyIndustryAssetItem

- (void)setImageArrayResourceName:(NSString *)imageArrayResourceName
{
    _imageArrayResourceName = imageArrayResourceName;
    [self loadImageArrayFromPlist];
}

- (void)loadImageArrayFromPlist
{
    NSString *filepath = [[NSBundle mainBundle] pathForResource:self.imageArrayResourceName ofType:@"plist"];
    self.images = [NSArray arrayWithContentsOfFile:filepath];
}

@end
