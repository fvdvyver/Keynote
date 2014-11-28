//
//  MCCollectionViewDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCCollectionViewDelegate.h"

@implementation MCCollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.eventHandler collectionView:collectionView didSelectItemAtIndexPath:indexPath];
}

@end
