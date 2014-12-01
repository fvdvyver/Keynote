//
//  CPSProductItemPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductItemPresenter.h"

#import "CPSProductAssetItem.h"

@interface CPSProductItemPresenter ()

- (NSURL *)videoFileURLForFilename:(NSString *)filename;

@end

@implementation CPSProductItemPresenter

- (void)configureVideoView:(id<CPSProductItemVideoView>)view withItem:(CPSProductAssetItem *)item
{
    NSURL *videoURL = [self videoFileURLForFilename:item.primaryFilename];
    
    [view setTitle:item.title];
    [view setVideoURL:videoURL loopVideo:item.loopsVideo];
}

- (NSURL *)videoFileURLForFilename:(NSString *)filename
{
    NSString *resourceName = [filename stringByDeletingPathExtension];
    NSString *pathExtension = [filename pathExtension];
    
    return [[NSBundle mainBundle] URLForResource:resourceName withExtension:pathExtension];
}

@end
