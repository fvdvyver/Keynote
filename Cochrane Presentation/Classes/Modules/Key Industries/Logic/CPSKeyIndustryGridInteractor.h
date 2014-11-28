//
//  CPSKeyIndustryGridInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSKeyIndustryGridInteractorIO.h"

@interface CPSKeyIndustryGridInteractor : NSObject <CPSKeyIndustryGridInteractorInput>

@property (nonatomic, strong) id<CPSKeyIndustryGridInteractorOutput> presenter;

@property (nonatomic, strong) NSArray * industryItems;

@end
