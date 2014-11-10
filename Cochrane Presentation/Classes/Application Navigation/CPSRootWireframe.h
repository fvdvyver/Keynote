//
//  CPSRootWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSRootPresenter.h"
#import "CPSViewControllerProvider.h"

@interface CPSRootWireframe : NSObject

@property (nonatomic, strong) id<CPSRootPresenter> presenter;

@property (nonatomic, strong) id<CPSViewControllerProvider> menuControllerProvider;
@property (nonatomic, strong) id<CPSViewControllerProvider> contentControllerProvider;

@end

