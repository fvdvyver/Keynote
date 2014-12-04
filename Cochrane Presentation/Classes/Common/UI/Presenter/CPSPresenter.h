//
//  CPSPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CPSBaseWireframe;
@protocol CPSInteractor;
@protocol CPSView;

@protocol CPSPresenter <NSObject>

@property (nonatomic, weak) CPSBaseWireframe * wireframe;
@property (nonatomic, weak) id<CPSInteractor>  interactor;
@property (nonatomic, weak) id<CPSView>        userInterface;

@end
