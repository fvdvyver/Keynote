//
//  CPSProductDetailViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/03.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPresenter.h"

#import "CPSVideoPlayerViewInterface.h"

@protocol CPSProductDetailView <CPSVideoPlayerViewInterface>

- (void)setTitle:(NSString *)title;
- (void)restartVideo; // play the current video again

@end

@protocol CPSProductDetailViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)viewTapped;
- (void)videoPlaybackFinished;

@end
