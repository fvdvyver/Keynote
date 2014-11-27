//
//  CPSVideoListInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"
#import "CPSPresenter.h"

@protocol CPSVideoListInteractorInput <CPSInteractor>

- (void)itemSelectedAtIndex:(NSUInteger)index;

@end

@protocol CPSVideoListInteractorOutput <CPSPresenter>

- (void)playVideoAtPath:(NSString *)path;

@end
