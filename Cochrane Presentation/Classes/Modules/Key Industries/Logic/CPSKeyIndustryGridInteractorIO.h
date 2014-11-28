//
//  CPSKeyIndustryGridInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"

@protocol CPSKeyIndustryGridInteractorInput <CPSInteractor>

- (void)requestData;

@end

@protocol CPSKeyIndustryGridInteractorOutput <CPSPresenter>

- (void)setIndustryItems:(NSArray *)industryItems;

@end
