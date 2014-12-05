//
//  CPSMvidView.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMvidView.h"

@implementation CPSMvidView

- (CGSize)intrinsicContentSize
{
    CGFloat scale = 1.0 / [[UIScreen mainScreen] scale];
    return CGSizeMake(self.image.size.width * scale, self.image.size.height * scale);
}

@end
