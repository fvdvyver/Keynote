//
//  CPSPlaceholderPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPlaceholderViewInterface.h"

@class CPSBaseWireframe;

@interface CPSPlaceholderPresenter : NSObject <CPSPlaceholderViewEventHandler>

@property (nonatomic, weak) CPSBaseWireframe * wireframe;

@property (nonatomic, strong) NSString * placeholderText;
@property (nonatomic, strong) id<CPSPlaceholderViewInterface> userInterface;

@end
