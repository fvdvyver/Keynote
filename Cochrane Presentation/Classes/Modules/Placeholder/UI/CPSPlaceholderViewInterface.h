//
//  CPSPlaceholderViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPresenter.h"
#import "CPSView.h"

@protocol CPSPlaceholderViewEventHandler <CPSPresenter>

- (void)updateView;
- (void)viewDoubleTapped;

@end

@protocol CPSPlaceholderViewInterface <CPSView>

- (void)setPlacholderText:(NSString *)placeholderText;

@end
