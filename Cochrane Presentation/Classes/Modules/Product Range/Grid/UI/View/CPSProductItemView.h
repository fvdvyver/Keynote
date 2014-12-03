//
//  CPSProductItemView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSImageMap;

@protocol CPSProductItemVideoView <NSObject>

- (void)setTitle:(NSString *)title;
- (void)setSpriteMap:(LSImageMap *)spriteMap;

@end
