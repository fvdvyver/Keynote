//
//  CPSVideoListResourcePresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListPresenter.h"

#import "CPSVideoListResourceInteractorIO.h"
#import "CPSVideoListResourceView.h"

@interface CPSVideoListResourcePresenter : CPSVideoListPresenter <CPSVideoListResourceInteractorOutput, CPSVideoListResourceViewEventHandler>

@property (nonatomic, weak) id <CPSVideoListResourceInteractorInput> interactor;
@property (nonatomic, weak) id <CPSVideoListResourceView> userInterface;

@end
