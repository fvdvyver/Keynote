//
//  CPSAnimatedTextTableViewCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CPSAnimatedTextView.h"

@interface CPSAnimatedTextTableViewCell : UITableViewCell

@property (nonatomic, strong) CPSAnimatedTextView * animatedTextView;

// Called on init. Remember to call the super implementation if overriding this
- (void)setupCell;

@end
