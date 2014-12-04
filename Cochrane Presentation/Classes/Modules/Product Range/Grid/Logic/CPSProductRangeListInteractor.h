//
//  CPSProductRangeListInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductRangeListInteractorIO.h"

#import "CPSProductRangeWireframe.h"

@interface CPSProductRangeListInteractor : NSObject <CPSProductRangeListInteractorInput>

@property (nonatomic, weak)   CPSProductRangeWireframe * wireframe;
@property (nonatomic, strong) id<CPSProductRangeListInteractorOutput> presenter;

@property (nonatomic, strong) NSArray * productItems;

@end
