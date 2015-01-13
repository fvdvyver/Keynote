//
//  CPSResourceListCollectionViewHeader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSResourceItemView.h"

@interface CPSResourceListCollectionViewHeader : UICollectionReusableView <CPSResourceListHeaderView>

@property (nonatomic, readonly) UILabel * titleLabel;

@end
