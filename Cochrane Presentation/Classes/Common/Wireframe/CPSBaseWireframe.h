//
//  CPSBaseWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSViewControllerProvider.h"
#import "CPSContentWireframe.h"

#import "CPSInteractor.h"
#import "CPSPresenter.h"
#import "CPSView.h"

/**
 *  Base content wireframe used to manage navigation between a single "page" (or presentation slide, in keynote terms). 
 *  A new view controller is created every time one is requested with the -contentViewController method.
 */
@interface CPSBaseWireframe : NSObject <CPSViewControllerProvider, CPSSubContentWireframe>

@property (nonatomic, weak) id<CPSContentWireframe> parentContentWireframe;

@property (nonatomic, strong) id<CPSInteractor> interactor;
@property (nonatomic, strong) id<CPSPresenter>  presenter;

@property (nonatomic, strong) NSString * storyboardName;
@property (nonatomic, strong) NSString * viewControllerIdentifier;

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName viewControllerID:(NSString *)identifer;

- (void)configureNewContentViewController:(UIViewController *)viewController;

- (UIStoryboard *)storyboard;
- (UIViewController *)instantiateNewViewControllerWithIdentifier:(NSString *)identifier;

@end
