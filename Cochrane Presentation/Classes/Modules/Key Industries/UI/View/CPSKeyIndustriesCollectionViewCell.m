//
//  CPSKeyIndustriesCollectionViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyIndustriesCollectionViewCell.h"

#import "CPSAppearanceConfig.h"

@interface CPSKeyIndustriesCollectionViewCell ()

- (void)updateTransformForState;

@end

@implementation CPSKeyIndustriesCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    self.textView.textContainer.lineFragmentPadding = 0;
    self.textView.textContainerInset = UIEdgeInsetsZero;
    
    CALayer *imageMask = [CALayer layer];
    imageMask.contents = (id)[UIImage imageNamed:@"key_industry_icon_clipping_mask"].CGImage;
    
    self.imageView.layer.mask = imageMask;
    
    self.imageContainerView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.imageContainerView.layer.shouldRasterize = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CALayer *imageMask = self.imageView.layer.mask;
    imageMask.frame = self.imageView.bounds;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateTransformForState];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateTransformForState];
}

- (void)updateTransformForState
{
    CGAffineTransform transform = (self.highlighted || self.selected) ? CGAffineTransformMakeScale(0.92, 0.92) : CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2
                          delay:0.0f
                        options:0
                     animations:^
     {
         self.transform = transform;
     }
                     completion:nil];
}

@end
