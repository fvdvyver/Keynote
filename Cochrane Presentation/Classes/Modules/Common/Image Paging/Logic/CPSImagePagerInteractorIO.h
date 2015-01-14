//
//  CPSImagePagerInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"
#import "CPSPresenter.h"

@protocol CPSImagePagerInteractorInput <CPSInteractor>

- (void)requestImagePagerData;

@end

@protocol CPSImagePagerInteractorOutput <CPSPresenter>

- (void)setTitle:(NSString *)title;
- (void)setInitialImageIndex:(NSUInteger)index;
- (void)setImageResources:(NSArray *)imageResources;

@end
