//
//  CPSInfoSpecTableViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSInfoSpecTableViewCell.h"

@implementation CPSInfoSpecTableViewCell

- (void)setupCell
{
    [super setupCell];
    
    UIFont *currentFont = self.animatedTextView.font;
    self.animatedTextView.font = [UIFont fontWithName:currentFont.fontName size:18.0];
    self.animatedTextView.textContainerInset = UIEdgeInsetsMake(1,
                                                                0,
                                                                -1,
                                                                0);
    
    self.imageView.image = [UIImage imageNamed:@"product_hex_icon"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGFloat leftInset = CGRectGetMaxX(self.imageView.frame) + 15.0;
    const CGFloat rightInset = 15.0;
    
    NSString *text = self.animatedTextView.originalText;
    CGSize boundingSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - (rightInset + leftInset), CGFLOAT_MAX);
    CGRect textRect = [text boundingRectWithSize:boundingSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                      attributes:@{ NSFontAttributeName : self.animatedTextView.font }
                                         context:nil];
    
    self.animatedTextView.frame = CGRectIntegral(CGRectMake(leftInset,
                                                            (CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(textRect)) / 2.0,
                                                            boundingSize.width,
                                                            CGRectGetHeight(textRect)));
}

- (void)setTitleText:(NSString *)text
{
    self.animatedTextView.text = text;
}

- (void)animateIn
{
    self.alpha = 0;
    [self.animatedTextView animateTextWithDuration:1.7];
    [UIView animateWithDuration:0.5 animations:^
    {
         self.alpha = 1.0;
    }];
}

@end
