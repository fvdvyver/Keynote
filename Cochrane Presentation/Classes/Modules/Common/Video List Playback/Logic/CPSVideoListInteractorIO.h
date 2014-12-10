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

- (void)requestAllVideoItems;
- (void)itemSelectedAtIndex:(NSUInteger)index;

@end

@protocol CPSVideoListInteractorOutput <CPSPresenter>

@required
- (void)playVideoAtPath:(NSString *)path;

@optional
/**
 *  Only implement this if you know the input will have -requestAllVideoItems called
 */
- (void)setAllVideoItems:(NSArray *)videoItems;

@end
