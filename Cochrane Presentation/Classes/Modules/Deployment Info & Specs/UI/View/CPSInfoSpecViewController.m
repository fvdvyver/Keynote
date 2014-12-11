//
//  CPSInfoSpecViewController.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/05.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import "CPSInfoSpecViewController.h"

#import "AVAnimatorView.h"
#import "AVAnimatorMedia.h"
#import "AVAppResourceLoader.h"
#import "AVFileUtil.h"
#import "AVMvidFrameDecoder.h"

#import "CPSAnimatedTextView.h"

#import "UITableView+CPSMaskingAdditions.h"
#import "CALayer+CPSImplicitActionRemoval.h"
#import "MPMoviePlayerController+CPSAdditions.h"

#import "CPSInfoSpecTableViewCell.h"

#import "NSString+MCKernAdditions.h"

#define kSelectProductText NSLocalizedString(@"PLEASE SELECT PRODUCT", nil)
#define kSecurityLevelText NSLocalizedString(@"SECURITY LEVEL", nil)

#define kTextAnimDuration 1.0

@interface CPSInfoSpecViewController ()

- (void)configureTableView;
- (void)configureTitleTextView;
- (void)configureInfoTextView;
- (void)configureSelectProductTextView;
- (void)configureSecurityLevelTextView;
- (void)configureContentVideoContainerView;

- (void)hideVisibleCells;
- (void)animateVisibleCellText;
- (void)animateTextViewText;

- (void)playMvidVideo:(NSString *)videoName inAnimatorView:(AVAnimatorView *)animatorView;

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
    paragraphStyle.minimumLineHeight = 20;

    self.infoTextView.textAttributes = @{
                                          NSParagraphStyleAttributeName : paragraphStyle,
                                          NSFontAttributeName : self.infoTextView.font,
                                          NSForegroundColorAttributeName : self.infoTextView.textColor
                                         };
}

- (void)configureSelectProductTextView
{
    self.selectProductTextView.text = nil;
}

- (void)configureSecurityLevelTextView
{
    // Making this clip prevents the last word from flashing when being animated
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByClipping;
    
    CGFloat kern = [kSecurityLevelText kernToFillWidth:CGRectGetWidth(self.securityLevelTextView.bounds) - 10.0
                                               withhFont:self.securityLevelTextView.font];

    self.securityLevelTextView.textAttributes = @{
                                                  NSParagraphStyleAttributeName : paragraphStyle,
                                                  NSKernAttributeName : @(kern),
                                                  NSFontAttributeName : self.securityLevelTextView.font,
                                                  NSForegroundColorAttributeName : self.securityLevelTextView.textColor
                                                  };

    self.securityLevelTextView.text = nil;
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
    [self configureInfoTextView];
    [self configureSelectProductTextView];
    [self configureSecurityLevelTextView];
    [self configureContentVideoContainerView];
}

- (void)contentViewDidAnimateIn
{
    [super contentViewDidAnimateIn];

    [self animateVisibleCellText];
    [self animateTextViewText];
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

- (void)animateTextViewText
{
    self.selectProductTextView.text = kSelectProductText;
    self.securityLevelTextView.text = kSecurityLevelText;
    
    [self.selectProductTextView animateTextWithDuration:kTextAnimDuration];
    [self.securityLevelTextView animateTextWithDuration:kTextAnimDuration];
}

- (void)showTitleText:(NSString *)titleText
{
    self.titleTextView.text = titleText;
    [self.titleTextView animateTextWithDuration:kTextAnimDuration];
}

- (void)showInfoText:(NSString *)infoText
{
    self.infoTextView.text = infoText;
    [self.infoTextView animateTextWithDuration:kTextAnimDuration];
}

- (void)playContentVideoAtURL:(NSURL *)url
{
    [super playContentVideoAtURL:url];
    self.selectProductTextView.hidden = YES;
}

- (void)playModelVideoWithName:(NSString *)videoName
{
    [self playMvidVideo:videoName inAnimatorView:self.modelAnimatorView];
}

- (void)playSecurityLevelVideoWithName:(NSString *)videoName
{
    [self playMvidVideo:videoName inAnimatorView:self.securityLevelAnimatorView];
    self.securityLevelAnimatorView.media.animatorRepeatCount = 0;
}

- (void)showSecurityLevelImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    [UIView transitionWithView:self.securityLevelAnimatorView
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^
                    {
                        [self.securityLevelAnimatorView setImage:image];
                    }
                    completion:nil];
}

- (void)playMvidVideo:(NSString *)videoName inAnimatorView:(AVAnimatorView *)animatorView
{
    if (videoName == nil)
    {
        [animatorView.media stopAnimator];
        [animatorView attachMedia:nil];
        [animatorView setImage:nil];

        return;
    }
    
    AVAnimatorMedia *media = [AVAnimatorMedia aVAnimatorMedia];
    media.animatorRepeatCount = INFINITY;
    
    AVAppResourceLoader *resLoader = [AVAppResourceLoader aVAppResourceLoader];
    resLoader.movieFilename = videoName;
    
    media.resourceLoader = resLoader;
    
    AVMvidFrameDecoder *frameDecoder = [AVMvidFrameDecoder aVMvidFrameDecoder];
    media.frameDecoder = frameDecoder;
    media.animatorFrameDuration = 1.0 / 25.0;
    
    [media prepareToAnimate];
    [animatorView attachMedia:media];
    
    [media startAnimator];
}

@end
