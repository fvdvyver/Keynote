//
//  CPSVideoPlayerViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSView.h"

@protocol CPSVideoPlayerViewInterface <CPSView>

- (void)playVideoAtURL:(NSURL *)videoURL;

@end
