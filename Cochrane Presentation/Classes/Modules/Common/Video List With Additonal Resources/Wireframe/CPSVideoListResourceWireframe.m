//
//  CPSVideoListResourceWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <QuickLook/QuickLook.h>

#import "CPSVideoListResourceWireframe.h"

#import "MCArrayQuickLookPreviewDataSource.h"

#import "CPSResourceListInteractor.h"
#import "CPSResourceListPresenter.h"
#import "CPSResourceListView.h"

#import "CPSResourceDirectory.h"
#import "CPSFileAssetItem+MIME.h"
#import "MCFilePathImageLoader.h"
#import "CPSResourceDirectory+FileTypeAdditions.h"

#import "CPSImagePagerInteractor.h"
#import "CPSImagePagerPresenter.h"
#import "CPSImagePagerView.h"

#import "CPSVideoPlayerInteractor.h"
#import "CPSVideoPlayerPresenter.h"
#import "CPSVideoPlayerViewInterface.h"

@interface CPSVideoListResourceWireframe ()

@property (nonatomic, strong) id<CPSInteractor> contentInteractor;

@property (nonatomic, strong) id quickLookDatasource;

- (void)showImageResource:(CPSFileAssetItem *)asset withDirectory:(CPSResourceDirectory *)directory;
- (void)showVideoResource:(CPSFileAssetItem *)asset;

- (void)presentFullScreenPDFViewForAsset:(CPSFileAssetItem *)asset;

@end

@implementation CPSVideoListResourceWireframe

- (void)showVideoItemAdditionalResources:(NSArray *)resources
{
    CPSResourceListInteractor *interactor = [CPSResourceListInteractor new];
    CPSResourceListPresenter *presenter = [CPSResourceListPresenter new];
    UIViewController<CPSResourceListView> * contentController = (id) [self instantiateNewViewControllerWithIdentifier:self.additionalResourceListViewControllerIdentifier];
    
    interactor.resourceDirectories = resources;
    interactor.wireframe = self;
    interactor.presenter = presenter;
    
    presenter.interactor = interactor;
    presenter.userInterface = contentController;
    
    contentController.eventHandler = presenter;
    if (self.additionalResourceViewInsetsString != nil)
    {
        [contentController setViewInsetsString:self.additionalResourceViewInsetsString];
    }
    
    [self.presenter.userInterface embedContentViewController:contentController];
    self.contentInteractor = interactor;
}

- (void)showResource:(CPSFileAssetItem *)resourceItem withDirectory:(CPSResourceDirectory *)directory
{
    switch (resourceItem.fileType)
    {
        case CPSFileAssetTypeImage:
        {
            [self showImageResource:resourceItem withDirectory:directory];
            [self.interactor resourceWasShown];
            break;
        }
        case CPSFileAssetTypeVideo:
        {
            [self showVideoResource:resourceItem];
            [self.interactor resourceWasShown];
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
    CPSImagePagerPresenter *presenter = [CPSImagePagerPresenter new];
    UIViewController<CPSImagePagerView> *imageController = (id)[self instantiateNewViewControllerWithIdentifier:self.imageResourceViewControllerIdentifier];
    
    NSArray *imagePaths = [directory filePathsForAllImages];
    NSInteger initialIndex = [imagePaths indexOfObject:asset.path];
    
    interactor.title = directory.directoryName;
    interactor.initialImageIndex = (initialIndex == NSNotFound) ? 0 : initialIndex;
    interactor.imageResources = imagePaths;
    interactor.presenter = presenter;
    
    presenter.interactor = interactor;
    presenter.userInterface = imageController;
    
    imageController.eventHandler = presenter;
    [imageController setBackgroundVisible:YES];
    
    // Do this on the next run loop so the UI can update first
    [(id)self.presenter.userInterface performSelector:@selector(embedContentViewController:)
                                           withObject:imageController afterDelay:0.0];
    
    self.contentInteractor = interactor;

}

- (void)showVideoResource:(CPSFileAssetItem *)asset
{
    CPSVideoPlayerInteractor *interactor = [CPSVideoPlayerInteractor new];
    CPSVideoPlayerPresenter *presenter = [CPSVideoPlayerPresenter new];
    UIViewController<CPSVideoPlayerViewInterface> *videoController = (id) [self instantiateNewViewControllerWithIdentifier:self.videoResourceViewControllerIdentifier];
    
    interactor.videoPath = asset.path;
    interactor.presenter = presenter;
    
    presenter.interactor = interactor;
    presenter.userInterface = videoController;
    
    videoController.eventHandler = presenter;
    
    [(id)self.presenter.userInterface performSelector:@selector(embedContentViewController:)
                                       withObject:videoController afterDelay:0.0];
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
