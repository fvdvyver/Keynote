//
//  CPSVideoThumbnailGenerationOperation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSVideoThumbnailGenerationOperation.h"

#import <pthread.h>
#import <AVFoundation/AVFoundation.h>

@interface CPSVideoThumbnailGenerationOperation ()

@property (nonatomic, strong) AVAssetImageGenerator * imageGenerator;
@property (nonatomic, assign) pthread_mutex_t mutex;

@end

@implementation CPSVideoThumbnailGenerationOperation

- (void)dealloc
{
    pthread_mutex_destroy(&_mutex);
}

- (instancetype)init
{
    if (self = [super init])
    {
        pthread_mutex_init(&_mutex, NULL);
    }
    return self;
}

- (void)main
{
    AVAsset *asset = [AVAsset assetWithURL:[NSURL fileURLWithPath:self.filePath]];
    
    pthread_mutex_lock(&_mutex);
    AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    self.imageGenerator = imageGenerator;
    pthread_mutex_unlock(&_mutex);
    
    CMTime time = CMTimeMake(1, 1);
    
    NSError *error = nil;
    CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:&error];
    
    if (error == nil && imageRef != NULL)
    {
        UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
        [self completeWithResultImage:[self resizeImage:thumbnail toSize:self.thumbnailSize]];
    }
    else
    {
        if (error != nil && !self.cancelled)
        {
            NSLog(@"An error occurred generating a video thumbnail: %@", error.localizedDescription);
        }
    }
    
    if (imageRef != NULL)
    {
        CGImageRelease(imageRef);
    }
}

- (void)cancel
{
    [super cancel];
    
    pthread_mutex_lock(&_mutex);
    [self.imageGenerator cancelAllCGImageGeneration];
    pthread_mutex_unlock(&_mutex);
}

@end
