//
//  CPSVideoPlayerInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/21.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"
#import "CPSVideoPlayerInteractorIO.h"

@interface CPSVideoPlayerInteractor : NSObject <CPSInteractor, CPSVideoPlayerInteractorInput>

@property (nonatomic, strong) id<CPSVideoPlayerInteractorOutput> presenter;

@property (nonatomic, strong) NSString * videoName;

@end
