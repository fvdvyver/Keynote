//
//  CPSCostOfRiskCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskCell.h"

#import "CPSAppearanceConfig.h"

@interface CPSCostOfRiskCell ()

- (void)setUpCostOfRiskCell;

@end

@implementation CPSCostOfRiskCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpCostOfRiskCell];
    }
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.animatedTextView.text = nil;
    [self.animatedTextView stopAnimating];
}

- (void)setUpCostOfRiskCell
{
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [UIView new];
    backgroundView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    
    self.selectedBackgroundView = backgroundView;
    
    CPSAnimatedTextView *textView = [CPSAnimatedTextView new];
    textView.textContainer.lineFragmentPadding = 0;
    textView.textContainerInset = UIEdgeInsetsMake(-3, 0, 3, 0); // this is to make sure the bottom of the text is not clipped with the specific font used
    textView.textColor = [UIColor whiteColor];
    textView.font = [UIFont fontWithName:kCPSApplicationFontDefaultName size:23];
    textView.backgroundColor = [UIColor clearColor];
    textView.userInteractionEnabled = NO;
    
    [self.contentView addSubview:textView];
    self.animatedTextView = textView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    const CGFloat textInset = 15.0;
    
    NSString *text = self.animatedTextView.originalText;
    CGRect textRect = [text boundingRectWithSize:CGRectInset(self.contentView.bounds, textInset, 0.0).size
                                         options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                      attributes:@{ NSFontAttributeName : self.animatedTextView.font }
                                         context:nil];
    
    self.animatedTextView.frame = CGRectIntegral(CGRectMake(textInset,
                                                            (CGRectGetHeight(self.contentView.bounds) - CGRectGetHeight(textRect)) / 2.0,
                                                            CGRectGetWidth(textRect),
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

- (void)stopAnimating
{
    [self.animatedTextView stopAnimating];
}

@end
