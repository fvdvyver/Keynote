//
//  CPSMarketingMaterialWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <QuickLook/QuickLook.h>

#import "CPSMarketingMaterialWireframe.h"

#import "MCArrayQuickLookPreviewDataSource.h"

#import "CPSResourceDirectory.h"
#import "CPSFileAssetItem+MIME.h"
#import "CPSResourceDirectory+FileTypeAdditions.h"

#import "CPSCachedViewControllerProvider.h"

#import "CPSImagePagerInteractor.h"
#import "CPSMarketingImagePagerPresenter.h"
#import "CPSImagePagerView.h"

#import "CPSVideoPlayerInteractor.h"
#import "CPSMarketingVideoPlayerPresenter.h"
#import "CPSVideoPlayerViewInterface.h"

@interface CPSMarketingMaterialWireframe ()

@property (nonatomic, strong) UIViewController * rootViewController;
@property (nonatomic, strong) id<CPSInteractor> contentInteractor;

@property (nonatomic, strong) id quickLookDatasource;

- (void)showImageResource:(CPSFileAssetItem *)asset withDirectory:(CPSResourceDirectory *)directory;
- (void)showVideoResource:(CPSFileAssetItem *)asset;

- (void)presentFullScreenPDFViewForAsset:(CPSFileAssetItem *)asset;

@end

@implementation CPSMarketingMaterialWireframe

- (void)prepareContentViewController
{
    // purge the cached content view controller because we have been requested to provide a new one
    self.rootViewController = nil;
    self.contentInteractor = nil;
    self.quickLookDatasource = nil;
}

- (UIViewController *)contentViewController
{
    UIViewController *viewController = [super contentViewController];
    self.rootViewController = viewController;
    
    return viewController;
}

- (void)showRootViewController
{
    self.contentInteractor = nil;
    [self.parentContentWireframe setContentControllerProvider:[CPSCachedViewControllerProvider providerWithCachedViewController:self.rootViewController]];
}

- (void)showResource:(CPSFileAssetItem *)resourceItem withDirectory:(CPSResourceDirectory *)directory
{
    switch (resourceItem.fileType)
    {
        case CPSFileAssetTypeImage:
        {
            [self showImageResource:resourceItem withDirectory:directory];
            break;
        }
        case CPSFileAssetTypeVideo:
        {
            [self showVideoResource:resourceItem];
            break;
        }
        case CPSFileAssetTypePDF:
        {
            [self presentFullScreenPDFViewForAsset:resourceItem];
            break;
        }
        default:
        {
            NSLog(@"Warning: Requested to show asset with unknown type %@", [resourceItem.path lastPathComponent]);
            break;
        }
    }
}

- (void)showImageResource:(CPSFileAssetItem *)asset withDirectory:(CPSResourceDirectory *)directory
{
    CPSImagePagerInteractor *interactor = [CPSImagePagerInteractor new];
    CPSImagePagerPresenter *presenter = [CPSMarketingImagePagerPresenter new];
    UIViewController<CPSImagePagerView> *imageController = (id)[self instantiateNewViewControllerWithIdentifier:self.imageResourceViewControllerIdentifier];
    
    NSArray *imagePaths = [directory filePathsForAllImages];
    NSInteger initialIndex = [imagePaths indexOfObject:asset.path];
    
    interactor.title = directory.directoryName;
    interactor.initialImageIndex = (initialIndex == NSNotFound) ? 0 : initialIndex;
    interactor.imageResources = imagePaths;
    interactor.presenter = presenter;
    
    presenter.wireframe = self;
    presenter.interactor = interactor;
    presenter.userInterface = imageController;
    
    imageController.eventHandler = presenter;
    [imageController setBackgroundVisible:YES];
    
    // Do this on the next run loop so the UI can update first
    [(id)self.parentContentWireframe performSelector:@selector(setContentControllerProvider:)
                                          withObject:[CPSCachedViewControllerProvider providerWithCachedViewController:imageController]
                                          afterDelay:0.0];
    
    self.contentInteractor = interactor;
}

- (void)showVideoResource:(CPSFileAssetItem *)asset
{
    CPSVideoPlayerInteractor *interactor = [CPSVideoPlayerInteractor new];
    CPSVideoPlayerPresenter *presenter = [CPSMarketingVideoPlayerPresenter new];
    UIViewController<CPSVideoPlayerViewInterface> *videoController = (id) [self instantiateNewViewControllerWithIdentifier:self.videoResourceViewControllerIdentifier];
    
    interactor.videoPath = asset.path;
    interactor.presenter = presenter;
    
    presenter.wireframe = self;
    presenter.interactor = interactor;
    presenter.userInterface = videoController;
    
    videoController.eventHandler = presenter;
    
    [(id)self.parentContentWireframe performSelector:@selector(setContentControllerProvider:)
                                          withObject:[CPSCachedViewControllerProvider providerWithCachedViewController:videoController]
                                          afterDelay:0.0];
    self.contentInteractor = interactor;
}

- (void)presentFullScreenPDFViewForAsset:(CPSFileAssetItem *)asset
{
    QLPreviewController *previewController = [[QLPreviewController alloc] init];
    MCArrayQuickLookPreviewDataSource *datasource = [MCArrayQuickLookPreviewDataSource new];
    
    datasource.filePaths = @[ asset.path ];
    
    previewController.dataSource = datasource;
    previewController.currentPreviewItemIndex = 0;
    
    UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    
    [rootViewController presentViewController:previewController
                                     animated:YES
                                   completion:nil];
    
    self.quickLookDatasource = datasource;
}

@end
