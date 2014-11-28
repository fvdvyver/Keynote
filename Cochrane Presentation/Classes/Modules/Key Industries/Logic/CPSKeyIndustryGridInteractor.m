//
//  CPSKeyIndustryGridInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustryGridInteractor.h"

@implementation CPSKeyIndustryGridInteractor

@synthesize wireframe = _wireframe;

- (void)requestData
{
    [self.presenter setIndustryItems:self.industryItems];
}

@end
