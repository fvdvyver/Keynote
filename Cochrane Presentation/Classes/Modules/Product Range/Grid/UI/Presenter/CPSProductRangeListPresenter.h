//
//  CPSProductRangeListPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductRangeWireframe.h"
#import "CPSProductRangeListInteractorIO.h"
#import "CPSProductRangeListViewInterface.h"

@class CPSProductAssetItem;

@interface CPSProductRangeListPresenter : NSObject <CPSProductRangeListInteractorOutput, CPSProductRangeListViewEventHandler>

@property (nonatomic, weak) CPSProductRangeWireframe * wireframe;
@property (nonatomic, weak) id<CPSProductRangeListInteractorInput> interactor;
@property (nonatomic, weak) id<CPSProductRangeListView> userInterface;

- (void)item:(CPSProductAssetItem *)item selectedAtIndex:(NSInteger)index;

@end
