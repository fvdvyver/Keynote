//
//  CPSInfoSpecInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListInteractor.h"
#import "CPSInfoSpecInteractorIO.h"

@interface CPSInfoSpecInteractor : CPSVideoListInteractor

@property (nonatomic, strong) id<CPSInfoSpecInteractorOutput> presenter;

@end
