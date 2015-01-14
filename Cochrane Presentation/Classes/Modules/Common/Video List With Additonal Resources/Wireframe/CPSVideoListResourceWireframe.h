//
//  CPSVideoListResourceWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"

#import "CPSVideoListResourceInteractorIO.h"
#import "CPSVideoListResourcePresenter.h"

#import "CPSResourceListWireframeInterface.h"

@class CPSVideoListResourceInteractor;
@class CPSAdditionalResourceAssetItem;

@interface CPSVideoListResourceWireframe : CPSBaseWireframe <CPSResourceListWireframeInterface>

@property (nonatomic, strong) NSString * additionalResourceViewInsetsString;
@property (nonatomic, strong) NSString * additionalResourceListViewControllerIdentifier;

@property (nonatomic, strong) NSString * imageResourceViewControllerIdentifier;
@property (nonatomic, strong) NSString * videoResourceViewControllerIdentifier;

@property (nonatomic, strong) id<CPSVideoListResourceInteractorInput> interactor;
@property (nonatomic, strong) CPSVideoListResourcePresenter *  presenter;

/**
 *  resources should be an array of CPSAdditionalResourceAssetItem
 */
- (void)showVideoItemAdditionalResources:(NSArray *)resources;

@end
