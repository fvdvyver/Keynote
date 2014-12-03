//
//  CPSProductItemCollectionViewCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSProductRangeListViewInterface.h"

#import "CPSAnimatedTextView.h"
#import "CPSAnimatedImageView.h"

@interface CPSProductItemCollectionViewCell : UICollectionViewCell <CPSProductItemVideoView>

@property (weak, nonatomic) IBOutlet CPSAnimatedTextView * textView;
@property (weak, nonatomic) IBOutlet CPSAnimatedImageView *imageView;

@end
