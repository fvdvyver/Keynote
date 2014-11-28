//
//  CPSKeyIndustriesGridPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustriesWireframe.h"

#import "CPSKeyIndustryGridInteractorIO.h"
#import "CPSKeyIndustriesViewInterface.h"

@class CPSAssetItem;

@interface CPSKeyIndustriesGridPresenter : NSObject <CPSKeyIndustryGridInteractorOutput, CPSKeyIndustriesViewEventHandler>

@property (nonatomic, weak)   CPSKeyIndustriesWireframe * wireframe;
@property (nonatomic, weak)   id<CPSKeyIndustryGridInteractorInput> interactor;
@property (nonatomic, strong) id<CPSKeyIndustriesView> userInterface;

- (void)item:(CPSAssetItem *)item selectedAtIndex:(NSInteger)index;

@end
