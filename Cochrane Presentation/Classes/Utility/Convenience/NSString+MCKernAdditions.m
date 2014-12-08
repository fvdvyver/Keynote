//
//  NSString+MCKernAdditions.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/08.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "NSString+MCKernAdditions.h"

@implementation NSString (MCKernAdditions)

- (CGFloat)kernToFillWidth:(CGFloat)width withhFont:(UIFont *)font
{
    if (self.length == 0)
    {
        return 0;
    }
    
    NSStringDrawingOptions options = (NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGRect boundingRect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.lineHeight)
                                             options:options
                                          attributes:@{ NSFontAttributeName : font }
                                             context:nil];
    
    CGFloat remainingWidth = width - boundingRect.size.width;
    if (remainingWidth <= 0)
    {
        return 0;
    }
    
    return remainingWidth / (CGFloat)self.length;
}

@end
