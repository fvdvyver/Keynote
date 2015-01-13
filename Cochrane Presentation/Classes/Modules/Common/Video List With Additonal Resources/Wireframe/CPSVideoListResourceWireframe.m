//
//  CPSVideoListResourceWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourceWireframe.h"

#import "CPSResourceListInteractor.h"
#import "CPSResourceListPresenter.h"
#import "CPSResourceListView.h"

@interface CPSVideoListResourceWireframe ()

@property (nonatomic, strong) id<CPSInteractor> contentInteractor;

@end

@implementation CPSVideoListResourceWireframe

- (void)showVideoItemAdditionalResources:(NSArray *)resources
{
    CPSResourceListInteractor *interactor = [CPSResourceListInteractor new];
    CPSResourceListPresenter *presenter = [CPSResourceListPresenter new];
    UIViewController<CPSResourceListView> * contentController = (id) [self instantiateNewViewControllerWithIdentifier:self.additionalResourceListViewControllerIdentifier];
    
    interactor.resourceDirectories = resources;
    interactor.wireframe = self;
    interactor.presenter = presenter;
    
    presenter.interactor = interactor;
    presenter.userInterface = contentController;
    
    contentController.eventHandler = presenter;
    
    [self.presenter.userInterface embedContentViewController:contentController];
    self.contentInteractor = interactor;
}

@end
