//
//  CPSLoadingViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPMoviePlayerController;

/**
 *  This view controller just plays a full screen video of the hive background with a schwing animation
 */
@interface CPSLoadingViewController : UIViewController

@property (nonatomic, strong) MPMoviePlayerController * backgroundVideoController;

@end
