//
//  CPSResourceListInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSInteractor.h"
#import "CPSPresenter.h"

@protocol CPSResourceListInteractorInput <CPSInteractor>

- (void)requestAllResourceItems;
- (void)itemSelectedAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol CPSResourceListInteractorOutput <CPSPresenter>

// This array will contain CPSResourceDirectory instances
- (void)setResourceDirectories:(NSArray *)resourceDirectories;

@end
