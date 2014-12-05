//
//  CPSVideoListViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSVideoListView.h"

@class MPMoviePlayerController;

@interface CPSVideoListViewController : UIViewController <CPSVideoListView>

@property (nonatomic, weak) id<CPSVideoListViewEventHandler> eventHandler;

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet UIView * contentView;
@property (nonatomic, weak) IBOutlet UIView * contentVideoContainerView;
@property (nonatomic, weak) IBOutlet UIView * backgroundVideoContainerView;

@property (nonatomic, assign) BOOL contentVideoShowsControls;

// These methods can be overridden to customize behaviour, but remember to call the super implementation
- (MPMoviePlayerController *)configureNewMovieControllerWithURL:(NSURL*)contentURL
                                                    inContainer:(UIView *)containerView
                                              isBackgroundVideo:(BOOL)isBackgroundVideo;

- (void)backgroundVideoPlaybackDidFinish;
- (void)contentViewDidAnimateIn;

@end
