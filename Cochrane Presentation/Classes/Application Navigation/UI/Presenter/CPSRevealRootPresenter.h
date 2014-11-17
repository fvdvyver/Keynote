//
//  CPSRevealRootPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MCRevealController.h>

#import "CPSRootPresenter.h"

/**
 *  Manages presentation of the root view using a reveal controller
 */
@interface CPSRevealRootPresenter : NSObject <CPSRootPresenter>

@property (nonatomic, strong) MCRevealController * revealController;

@end
