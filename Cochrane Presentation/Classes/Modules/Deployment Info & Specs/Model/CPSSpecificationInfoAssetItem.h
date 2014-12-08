//
//  CPSSpecificationInfoAssetItem.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAssetItem.h"

@interface CPSSpecificationInfoAssetItem : CPSAssetItem

@property (nonatomic, strong) NSString * navigationIdentifier;

@property (nonatomic, strong) NSArray *  details;
@property (nonatomic, strong) NSString * modelVideoName;
@property (nonatomic, strong) NSString * securityLevelVideoName;
@property (nonatomic, strong) NSString * securityLevelImageName;

@end
