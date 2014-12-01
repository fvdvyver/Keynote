//
//  CPSRightToLeftFlowLayout.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSRightToLeftFlowLayout.h"

@implementation CPSRightToLeftFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in attributesArray)
    {
        CGRect frame = attributes.frame;
        frame.origin.x = rect.size.width - frame.size.width - frame.origin.x;

        attributes.frame = frame;
    }
    return attributesArray;
}

@end
