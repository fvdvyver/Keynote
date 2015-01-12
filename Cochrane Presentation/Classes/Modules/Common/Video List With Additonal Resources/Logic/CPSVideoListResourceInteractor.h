//
//  CPSVideoListResourceInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractor.h"

#import "CPSVideoListResourceWireframe.h"
#import "CPSVideoListResourceInteractorIO.h"

@interface CPSVideoListResourceInteractor : CPSVideoListInteractor <CPSVideoListResourceInteractorInput>

@property (nonatomic, weak)   CPSVideoListResourceWireframe * wireframe;
@property (nonatomic, strong) id<CPSVideoListResourceInteractorOutput> presenter;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
