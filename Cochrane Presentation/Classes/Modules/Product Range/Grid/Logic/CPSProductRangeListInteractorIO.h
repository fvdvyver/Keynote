//
//  CPSProductRangeListInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"

@protocol CPSProductRangeListInteractorInput <CPSInteractor>

- (void)requestData;

@end

@protocol CPSProductRangeListInteractorOutput <CPSPresenter>

// The image map dictionary will map the name of the image map to the LSImageMap instance
- (void)setProductItems:(NSArray *)productItems withImageMapDictionary:(NSDictionary *)imageMaps;

@end
