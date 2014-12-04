//
//  CPSProductItemCollectionViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductItemCollectionViewCell.h"

#import "LSImageMap.h"
#import "CPSImageViewAnimator.h"

@interface CPSProductItemCollectionViewCell ()

- (void)updateTransformForState;

@end

@implementation CPSProductItemCollectionViewCell

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.textView.text = nil;
}

- (void)setTitle:(NSString *)title
{
    self.textView.text = title;
}

- (void)setSpriteMap:(LSImageMap *)spriteMap
{
    self.imageView.spriteImageMap = spriteMap;
    if (spriteMap.imageCount > 0)
    {
        self.imageView.animator = [CPSImageViewAnimator sharedAnimator];
    }
    else
    {
        self.imageView.animator = nil;
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.spriteImageMap.imageCount > 0)
    {
        [self.imageView sizeToFit];
        self.imageView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.0,
                                            CGRectGetMinY(self.textView.frame) / 2.0);
    }
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
