//
//  CPSMarketingMaterialWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSBaseWireframe.h"
#import "CPSResourceListWireframeInterface.h"

@interface CPSMarketingMaterialWireframe : CPSBaseWireframe <CPSResourceListWireframeInterface>

@property (nonatomic, strong) NSString * imageResourceViewControllerIdentifier;
@property (nonatomic, strong) NSString * videoResourceViewControllerIdentifier;

- (void)showRootViewController;

@end
