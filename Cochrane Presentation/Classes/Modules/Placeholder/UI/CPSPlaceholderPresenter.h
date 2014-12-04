//
//  CPSPlaceholderPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPlaceholderViewInterface.h"

@interface CPSPlaceholderPresenter : NSObject <CPSPlaceholderViewEventHandler>

@property (nonatomic, weak) id<CPSPlaceholderViewInterface> userInterface;

@property (nonatomic, strong) NSString * placeholderText;

@end
