//
//  CPSKeyIndustriesCollectionViewCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/28.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSAnimatedTextView.h"

@interface CPSKeyIndustriesCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet CPSAnimatedTextView * textView;

@property (nonatomic, weak) IBOutlet UIView *      imageContainerView;
@property (nonatomic, weak) IBOutlet UIImageView * imageView;

@end
