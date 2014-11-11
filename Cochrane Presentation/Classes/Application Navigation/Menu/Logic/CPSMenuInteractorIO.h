//
//  CPSMenuInteractorIO.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/11.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSMenuItem;

@protocol CPSMenuInteractorInput <NSObject>

- (void)requestOutputDataUpdate;
- (void)updateOutput;

- (void)selectMenuItem:(CPSMenuItem *)item;

@end

@protocol CPSMenuInteractorOutput <NSObject>

- (void)setMenuItems:(NSArray *)menuItems;
- (void)setSelectedMenuItem:(CPSMenuItem *)menuItem;

@end
