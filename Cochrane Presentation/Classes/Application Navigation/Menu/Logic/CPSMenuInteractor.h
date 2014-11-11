//
//  CPSMenuInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSMenuInteractorIO.h"
#import "CPSMenuItem.h"

@interface CPSMenuInteractor : NSObject <CPSMenuInteractorInput>

@property (nonatomic, strong) NSArray * menuItems;
@property (nonatomic, strong) id<CPSMenuItemDelegate> menuDelegate;
@property (nonatomic, strong) CPSMenuItem * selectedMenuItem;

@property (nonatomic, strong) id<CPSMenuInteractorOutput> output;

@end
