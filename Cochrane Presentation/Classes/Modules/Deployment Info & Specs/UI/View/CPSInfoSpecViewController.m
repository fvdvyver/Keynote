//
//  CPSInfoSpecViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "CPSInfoSpecViewController.h"

#import "CPSAnimatedTextView.h"

#import "UITableView+CPSMaskingAdditions.h"
#import "CALayer+CPSImplicitActionRemoval.h"
#import "MPMoviePlayerController+CPSAdditions.h"

#import "CPSInfoSpecTableViewCell.h"

@interface CPSInfoSpecViewController ()

- (void)configureTableView;
- (void)configureTitleTextView;
- (void)configureInfoTextView;
- (void)configureContentVideoContainerView;

- (void)hideVisibleCells;
- (void)animateVisibleCellText;

@end

@implementation CPSInfoSpecViewController

- (void)configureTableView
{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
    [self.tableView registerClass:[CPSInfoSpecTableViewCell class]
           forCellReuseIdentifier:[self cellReuseIdentifier]];
    
    [self.tableView cps_configureTableViewMaskWithImage:[UITableView cps_maskImageNameForInfoAndSpecsTable]
                                                 insets:[UITableView cps_insetsForInfoAndSpecsTableMask]];
}

- (void)configureTitleTextView;
{
    CGFloat textInset = 3.0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    self.titleTextView.textContainerInset = UIEdgeInsetsMake(-textInset, 0, textInset, 0);
    self.titleTextView.textContainer.lineFragmentPadding = 0.0;
    self.titleTextView.textAttributes = @{
                                           NSKernAttributeName : @5,
                                           NSFontAttributeName : self.titleTextView.font,
                                           NSForegroundColorAttributeName : self.titleTextView.textColor,
                                           NSParagraphStyleAttributeName : paragraphStyle
                                          };
}

- (void)configureInfoTextView
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = 40;
    
    self.infoTextView.textAttributes = @{
                                          NSParagraphStyleAttributeName : paragraphStyle,
                                          NSFontAttributeName : self.titleTextView.font,
                                          NSForegroundColorAttributeName : self.titleTextView.textColor
                                         };
}

- (void)configureContentVideoContainerView
{
    UIImage *maskImage = [UIImage imageNamed:@"info_specs_video_mask"];
    CALayer *maskLayer = [CALayer layer];
    maskLayer.contentsScale = [[UIScreen mainScreen] scale];
    maskLayer.frame = CGRectMake(0, 0, maskImage.size.width, maskImage.size.height);
    maskLayer.contents = (id)maskImage.CGImage;
    [maskLayer cps_removeImplicitActions];
    
    self.contentVideoContainerView.layer.mask = maskLayer;
}

- (MPMoviePlayerController *)configureNewMovieControllerWithURL:(NSURL*)contentURL
                                                    inContainer:(UIView *)containerView
                                              isBackgroundVideo:(BOOL)isBackgroundVideo
{
    MPMoviePlayerController *videoController = [super configureNewMovieControllerWithURL:contentURL
                                                                             inContainer:containerView
                                                                       isBackgroundVideo:isBackgroundVideo];
    videoController.scalingMode = MPMovieScalingModeAspectFill;
    if (!isBackgroundVideo)
    {
        [videoController setControlStyleHidingInitially:MPMovieControlStyleFullscreen];
        [videoController.view setUserInteractionEnabled:YES];
    }
    
    return videoController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configureTableView];
    [self configureTitleTextView];
    [self configureContentVideoContainerView];
}

- (void)contentViewDidAnimateIn
{
    [super contentViewDidAnimateIn];
    [self animateVisibleCellText];
}

- (void)setTableViewDatasource:(id<UITableViewDataSource>)datasource
{
    [super setTableViewDatasource:datasource];
    [self.tableView reloadData];

    [self hideVisibleCells];
}

- (void)hideVisibleCells
{
    for (CPSInfoSpecTableViewCell *cell in self.tableView.visibleCells)
    {
        [cell setAlpha:0.0];
    }
}

- (void)animateVisibleCellText
{
    for (CPSInfoSpecTableViewCell *cell in self.tableView.visibleCells)
    {
        [cell animateIn];
    }
}

- (void)showTitleText:(NSString *)titleText
{
    self.titleTextView.text = titleText;
    [self.titleTextView animateTextWithDuration:1.0];
}

- (void)showInfoText:(NSString *)infoText
{
    self.infoTextView.text = infoText;
}

- (void)playModelVideoWithName:(NSString *)videoName
{
    
}

@end
