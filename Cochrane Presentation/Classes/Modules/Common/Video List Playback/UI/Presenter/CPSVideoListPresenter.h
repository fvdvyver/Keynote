//
//  CPSVideoListPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSVideoListInteractorIO.h"
#import "CPSVideoListView.h"

/**
 *  Abstract presenter for video list playback that can be subclassed. This implementation does not provide a method of setting the datasource, and does not update the data source of its user interface either.
 */
@interface CPSVideoListPresenter : NSObject <CPSVideoListInteractorOutput, CPSVideoListViewEventHandler>

@property (nonatomic, weak)   id <CPSVideoListInteractorInput> interactor;
@property (nonatomic, strong) id <CPSVideoListView> userInterface;

@property (nonatomic, strong) NSString * introVideoFilename;

// This can be overridden to customize behaviour. Remember to call the super implementation
- (void)introVideoPlaybackCompleted;

@end
