//
//  CPSKeyIndustryAssetItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/09.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSAssetItem.h"

@interface CPSKeyIndustryAssetItem : CPSAssetItem

// The name of the list of images. Setting this will cause the list of images to be automatically loaded from file
@property (nonatomic, strong) NSString * imageArrayResourceName;

@property (nonatomic, strong) NSArray *  images;

@end
