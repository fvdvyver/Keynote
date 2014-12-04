//
//  CPSVideoPlayerPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoPlayerPresenterInterface.h"
#import "CPSVideoPlayerInteractorIO.h"
#import "CPSVideoPlayerViewInterface.h"

@interface CPSVideoPlayerPresenter : NSObject <CPSVideoPlayerInteractorOutput, CPSVideoPlayerEventHandler>

@property (nonatomic, weak) id<CPSVideoPlayerInteractorInput> interactor;
@property (nonatomic, weak) id<CPSVideoPlayerViewInterface>   userInterface;

@end
