//
//  CPSVideoListResourceWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"
#import "CPSVideoListResourcePresenter.h"

@class CPSAdditionalResourceAssetItem;

@interface CPSVideoListResourceWireframe : CPSBaseWireframe

@property (nonatomic, strong) NSString * additionalResourceListViewControllerIdentifier;

@property (nonatomic, strong) CPSVideoListResourcePresenter * presenter;

/**
 *  resources should be an array of CPSAdditionalResourceAssetItem
 */
- (void)showVideoItemAdditionalResources:(NSArray *)resources;

@end
