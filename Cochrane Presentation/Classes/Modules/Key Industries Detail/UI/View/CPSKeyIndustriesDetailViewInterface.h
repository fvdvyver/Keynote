//
//  CPSKeyIndustriesDetailViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSView.h"
#import "CPSPresenter.h"

@protocol CPSKeyIndustriesDetailView <CPSView>

- (void)setTitle:(NSString *)title;
- (void)setImageNames:(NSArray *)imageNames;

@end

@protocol CPSKeyIndustriesDetailViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)viewTapped;

@end
