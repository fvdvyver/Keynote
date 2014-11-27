//
//  CPSVideoListInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListInteractorIO.h"

@class CPSVideoListItem;

/**
 *  Abstract base class interactor for video list playback. This class can be subclassed to provide the presenter with video list data.
 */
@interface CPSVideoListInteractor : NSObject <CPSVideoListInteractorInput>

@property (nonatomic, strong) id<CPSVideoListInteractorOutput> presenter;

// must be an array of CPSVideoListItem
@property (nonatomic, copy) NSArray *videoItems;

- (void)playVideoForItem:(CPSVideoListItem *)item;

@end
