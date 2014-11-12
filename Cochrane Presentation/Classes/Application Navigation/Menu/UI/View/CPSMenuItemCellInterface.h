//
//  CPSMenuItemCellInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/12.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPSMenuItemCellInterface <NSObject>

- (void)setTitle:(NSString *)title;
- (void)setIcon:(UIImage *)icon;

@end
