//
//  CPSKeyIndustriesWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"

@interface CPSKeyIndustriesWireframe : CPSBaseWireframe

- (void)showIndustryWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (void)showMainViewController;
- (void)navigateToProductRange;

@end
