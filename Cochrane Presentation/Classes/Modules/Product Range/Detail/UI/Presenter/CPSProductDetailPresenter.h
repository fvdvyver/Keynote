//
//  CPSProductDetailPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/03.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductDetailViewInterface.h"
#import "CPSProductRangeWireframe.h"

@interface CPSProductDetailPresenter : NSObject <CPSProductDetailViewEventHandler>

@property (nonatomic, weak)   CPSProductRangeWireframe * wireframe;
@property (nonatomic, strong) id<CPSProductDetailView>   userInterface;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * videoName;

@end
