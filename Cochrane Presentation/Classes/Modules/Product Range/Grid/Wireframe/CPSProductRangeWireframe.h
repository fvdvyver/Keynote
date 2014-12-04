//
//  CPSProductRangeWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"

@interface CPSProductRangeWireframe : CPSBaseWireframe

@property (nonatomic, strong) NSString * loadingViewControllerIdentifier;
@property (nonatomic, strong) NSString * detailViewControllerIdentifier;

- (void)hideLoadingView;
- (void)showProductWithTitle:(NSString *)title videoName:(NSString *)videoName;
- (void)showMainViewController;

@end
