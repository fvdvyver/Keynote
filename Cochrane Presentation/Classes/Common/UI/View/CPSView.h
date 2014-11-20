//
//  CPSView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPSPresenter;

@protocol CPSView <NSObject>

@property (nonatomic, weak) id<CPSPresenter> eventHandler;

@end
