//
//  CPSImagePagerPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSImagePagerInteractorIO.h"
#import "CPSImagePagerView.h"

@interface CPSImagePagerPresenter : NSObject <CPSImagePagerInteractorOutput, CPSImagePagerViewEventHandler>

@property (nonatomic, weak) id<CPSImagePagerInteractorInput> interactor;
@property (nonatomic, weak) id<CPSImagePagerView>            userInterface;

// Default implementation uses MCFilePathImageLoader instances
- (NSArray *)imageLoadersForImageResources:(NSArray *)imageResources;

@end
