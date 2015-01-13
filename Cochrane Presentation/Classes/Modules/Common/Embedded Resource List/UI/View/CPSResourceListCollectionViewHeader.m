//
//  CPSResourceListCollectionViewHeader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceListCollectionViewHeader.h"

#import "CPSAppearanceConfig.h"

@interface CPSResourceListCollectionViewHeader ()

- (void)setupResourceListHeader;

@end

@implementation CPSResourceListCollectionViewHeader

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupResourceListHeader];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder])
    {
        [self setupResourceListHeader];
    }
    return self;
}

- (void)setupResourceListHeader
{
    UILabel *titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:kCPSApplicationFontDefaultName size:17.0];
    
    _titleLabel = titleLabel;
    [self addSubview:self.titleLabel];
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectInset(self.bounds, 20.0, 0.0);
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

@end
