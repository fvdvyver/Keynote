//
//  CPSProductItemCollectionViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductItemCollectionViewCell.h"

@implementation CPSProductItemCollectionViewCell

- (void)prepareForReuse
{
    [super prepareForReuse];

    self.textView.text = nil;
    self.imageView.image = nil;
}

- (void)setTitle:(NSString *)title
{
    self.textView.text = title;
}

- (void)setVideoURL:(NSURL *)videoURL loopVideo:(BOOL)loop
{
    
}

@end
