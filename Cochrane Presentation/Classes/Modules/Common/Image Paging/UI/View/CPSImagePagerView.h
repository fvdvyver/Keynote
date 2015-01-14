//
//  CPSImagePagerView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSView.h"

@protocol CPSImagePagerView <CPSView>

- (void)setTitle:(NSString *)title;
- (void)setImageIndex:(NSUInteger)index;
- (void)setImageLoaders:(NSArray *)imageLoaders;

- (void)setBackgroundVisible:(BOOL)visible;

@end

@protocol CPSImagePagerViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)viewTapped;

@end
