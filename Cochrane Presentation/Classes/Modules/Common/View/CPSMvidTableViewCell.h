//
//  CPSMvidTableViewCell.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef IBInspectable
#define IBInspectable
#endif

#import "AVAnimatorView.h"

/**
 *  A cell with a centered AVAnimatorView which will automatically play & loop the video when set
 */
@interface CPSMvidTableViewCell : UITableViewCell

@property (nonatomic, strong) AVAnimatorView * animatorView;
@property (nonatomic, assign) IBInspectable CGSize animatorOffset;

- (void)playMvidFileWithName:(NSString *)fileName;

@end
