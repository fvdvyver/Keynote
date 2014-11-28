//
//  MCCollectionViewDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MCCollectionViewDelegateEventHandler;

@interface MCCollectionViewDelegate : NSObject <UICollectionViewDelegate>

@property (nonatomic, weak) id<MCCollectionViewDelegateEventHandler> eventHandler;

@end

@protocol MCCollectionViewDelegateEventHandler <NSObject>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end