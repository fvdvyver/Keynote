//
//  CPSVideoListResourceInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListInteractorIO.h"

@protocol CPSVideoListResourceInteractorInput <CPSVideoListInteractorInput>

- (void)requestResourceForSelectedVideoItem;
- (void)resourceWasShown;

@end

@protocol CPSVideoListResourceInteractorOutput <CPSVideoListInteractorOutput>

- (void)setItemResourceButtonVisible:(BOOL)visible;

@end
