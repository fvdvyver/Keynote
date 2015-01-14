//
//  CPSImagePagerInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSImagePagerInteractorIO.h"

@interface CPSImagePagerInteractor : NSObject <CPSImagePagerInteractorInput>

@property (nonatomic, strong) id<CPSImagePagerInteractorOutput> presenter;

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray * imageResources;
@property (nonatomic, assign) NSUInteger initialImageIndex;

@end
