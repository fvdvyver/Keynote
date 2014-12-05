//
//  CALayer+CPSImplicitActionRemoval.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (CPSImplicitActionRemoval)

- (void)cps_removeImplicitActions;

@end
