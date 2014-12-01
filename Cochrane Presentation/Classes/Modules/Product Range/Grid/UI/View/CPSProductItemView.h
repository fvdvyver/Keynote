//
//  CPSProductItemView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSProductItemVideoView <NSObject>

- (void)setTitle:(NSString *)title;
- (void)setVideoURL:(NSURL *)videoURL loopVideo:(BOOL)loop;

@end
