//
//  CPSInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSBaseWireframe;
@protocol CPSPresenter;

@protocol CPSInteractor <NSObject>

@property (nonatomic, weak)   CPSBaseWireframe * wireframe;
@property (nonatomic, strong) id<CPSPresenter>   presenter;

@end
