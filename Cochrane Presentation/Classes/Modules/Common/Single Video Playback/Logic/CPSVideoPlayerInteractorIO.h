//
//  CPSVideoPlayerInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPSInteractor;
@protocol CPSPresenter;

@protocol CPSVideoPlayerInteractorInput <CPSInteractor>

- (void)requestVideoFilepath;

@end

@protocol CPSVideoPlayerInteractorOutput <CPSPresenter>

- (void)playVideoAtPath:(NSString *)videoPath;

@end
