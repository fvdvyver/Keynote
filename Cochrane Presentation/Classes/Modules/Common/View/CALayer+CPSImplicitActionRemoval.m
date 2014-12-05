//
//  CALayer+CPSImplicitActionRemoval.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CALayer+CPSImplicitActionRemoval.h"

@implementation CALayer (CPSImplicitActionRemoval)

- (void)cps_removeImplicitActions
{
    self.actions = @{
                     @"onOrderIn"  : [NSNull null],
                     @"onOrderOut" : [NSNull null],
                     @"sublayers"  : [NSNull null],
                     @"contents"   : [NSNull null],
                     @"bounds"     : [NSNull null],
                     @"position"   : [NSNull null]
                     };
}

@end
