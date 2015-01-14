//
//  CPSKeyIndustriesDetailPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustriesWireframe.h"
#import "CPSImagePagerPresenter.h"

@class CPSKeyIndustriesWireframe;

@interface CPSKeyIndustriesDetailPresenter : CPSImagePagerPresenter

@property (nonatomic, weak) CPSKeyIndustriesWireframe * wireframe;
@property (nonatomic, weak) id<CPSImagePagerView>       userInterface;

@end
