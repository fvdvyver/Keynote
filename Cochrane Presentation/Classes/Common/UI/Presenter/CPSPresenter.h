//
//  CPSPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSView;

@protocol CPSPresenter <NSObject>

@property (nonatomic, weak) id wireframe;
@property (nonatomic, strong) id<CPSView> userInterface;

@end
