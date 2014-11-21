//
//  CPSVideoPlaybackViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSVideoPlayerViewInterface.h"
#import "CPSVideoPlayerPresenterInterface.h"

@interface CPSVideoPlaybackViewController : UIViewController <CPSVideoPlayerViewInterface>

@property (nonatomic, weak) id<CPSVideoPlayerEventHandler> eventHandler;

@end
