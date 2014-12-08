//
//  CPSInfoSpecViewController.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoListViewController.h"

#import "CPSInfoSpecViewInterface.h"

@class CPSAnimatedTextView;
@class AVAnimatorView;

@interface CPSInfoSpecViewController : CPSVideoListViewController <CPSInfoSpecView>

@property (nonatomic, weak) IBOutlet CPSAnimatedTextView *titleTextView;
@property (nonatomic, weak) IBOutlet CPSAnimatedTextView *infoTextView;
@property (nonatomic, weak) IBOutlet AVAnimatorView *modelAnimatorView;
@property (weak, nonatomic) IBOutlet AVAnimatorView *securityLevelAnimatorView;

@end
