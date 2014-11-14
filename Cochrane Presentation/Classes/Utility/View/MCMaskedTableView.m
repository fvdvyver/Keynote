//
//  MCMaskedTableView.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCMaskedTableView.h"

@implementation MCMaskedTableView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.layer.mask != nil)
    {
        CGRect maskFrame = self.layer.mask.frame;
        CGPoint offset = self.contentOffset;
        
        maskFrame.origin = CGPointMake(offset.x, offset.y);
        self.layer.mask.frame = maskFrame;
    }
}

@end
