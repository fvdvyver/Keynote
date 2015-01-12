//
//  CPSInfoSpecPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListResourcePresenter.h"

#import "CPSInfoSpecInteractorIO.h"
#import "CPSInfoSpecViewInterface.h"

@interface CPSInfoSpecPresenter : CPSVideoListResourcePresenter <CPSInfoSpecInteractorOutput>

@property (nonatomic, weak) id<CPSInfoSpecInteractorInput> interactor;
@property (nonatomic, weak) id <CPSInfoSpecView> userInterface;

@end
