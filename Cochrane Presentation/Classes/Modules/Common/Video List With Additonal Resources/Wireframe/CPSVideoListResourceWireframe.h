//
//  CPSVideoListResourceWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"
#import "CPSVideoListResourcePresenter.h"

@interface CPSVideoListResourceWireframe : CPSBaseWireframe

@property (nonatomic, strong) NSString * additionalResourceListViewControllerIdentifier;

@property (nonatomic, strong) CPSVideoListResourcePresenter * presenter;

// TODO: create data model for list of resources
- (void)showVideoItemAdditionalResources:(id)resources;

@end
