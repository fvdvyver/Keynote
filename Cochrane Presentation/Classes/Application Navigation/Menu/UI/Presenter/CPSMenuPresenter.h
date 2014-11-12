//
//  CPSMenuPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSMenuInteractorIO.h"
#import "CPSMenuViewInterface.h"

@interface CPSMenuPresenter : NSObject <CPSMenuInteractorOutput, CPSMenuViewEventHandler>

@property (nonatomic, weak) id<CPSMenuInteractorInput> input;
@property (nonatomic, strong) id<CPSMenuViewInterface> userInterface;

@end
