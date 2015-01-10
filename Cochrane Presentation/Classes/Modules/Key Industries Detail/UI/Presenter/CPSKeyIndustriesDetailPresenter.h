//
//  CPSKeyIndustriesDetailPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustriesWireframe.h"
#import "CPSKeyIndustriesDetailViewInterface.h"

@class CPSKeyIndustriesWireframe;

@interface CPSKeyIndustriesDetailPresenter : NSObject <CPSKeyIndustriesDetailViewEventHandler>

@property (nonatomic, weak) CPSKeyIndustriesWireframe * wireframe;
@property (nonatomic, weak) id<CPSKeyIndustriesDetailView> userInterface;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray *  imageNames;

@end
