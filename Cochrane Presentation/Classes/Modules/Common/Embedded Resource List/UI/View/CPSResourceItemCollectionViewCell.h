//
//  CPSResourceItemCollectionViewCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSResourceItemView.h"

@interface CPSResourceItemCollectionViewCell : UICollectionViewCell <CPSResourceItemView>

@property (nonatomic, weak) IBOutlet UILabel *     titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView * imageView;
@property (nonatomic, weak) IBOutlet UIImageView *typeImageView;

- (void)setImage:(UIImage *)image animated:(BOOL)animated;
           
@end
