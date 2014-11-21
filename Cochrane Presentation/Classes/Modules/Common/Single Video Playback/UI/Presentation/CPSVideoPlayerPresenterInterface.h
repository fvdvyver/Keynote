//
//  CPSVideoPlayerPresenterInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPresenter.h"

@protocol CPSVideoPlayerEventHandler <CPSPresenter>

- (void)updateView;
- (void)viewDoubleTapped;
- (void)videoPlaybackFinished;

@end
