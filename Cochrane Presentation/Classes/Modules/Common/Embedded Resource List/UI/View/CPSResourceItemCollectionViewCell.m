//
//  CPSResourceItemCollectionViewCell.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceItemCollectionViewCell.h"

#import "CPSThumbnailGeneratorOperation.h"

#define kImageSize (CGSize) { 136, 104 }

@interface CPSResourceItemCollectionViewCell ()

@property (nonatomic, strong) CPSThumbnailGeneratorOperation * operation;

+ (NSOperationQueue *)thumbnailOperationQueue;
+ (NSCache *)thumbnailCache;

- (void)loadThumbnailForAssetPath:(NSString *)assetPath type:(CPSFileAssetType)type;
- (void)imageLoadCompletedWithImage:(UIImage *)image
                          forOperation:(CPSThumbnailGeneratorOperation *)operation;

- (void)updateTransformForState;

@end

@implementation CPSResourceItemCollectionViewCell

+ (NSOperationQueue *)thumbnailOperationQueue
{
    static NSOperationQueue *queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        queue = [NSOperationQueue new];
        queue.maxConcurrentOperationCount = 1;
        queue.qualityOfService = NSQualityOfServiceBackground;
    });
    
    return queue;
}

+ (NSCache *)thumbnailCache
{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        cache = [NSCache new];
        cache.countLimit = 100;
    });
    
    return cache;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.titleLabel.text = nil;
    self.imageView.image = nil;
    
    [self.operation cancel];
    self.operation = nil;
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateTransformForState];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self updateTransformForState];
}

- (void)updateTransformForState
{
    CGAffineTransform transform = (self.highlighted || self.selected) ? CGAffineTransformMakeScale(0.92, 0.92) : CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2
                          delay:0.0f
                        options:0
                     animations:^
                     {
                         self.transform = transform;
                     }
                     completion:nil];
}

- (void)setOperation:(CPSThumbnailGeneratorOperation *)operation
{
    if (self.operation != nil)
    {
        [self.operation cancel];
    }
    
    _operation = operation;
}

- (void)loadThumbnailForAssetPath:(NSString *)assetPath type:(CPSFileAssetType)type
{
    self.operation = [CPSThumbnailGeneratorOperation operationWithFileType:type
                                                                  filePath:assetPath
                                                                      size:kImageSize];
    if (self.operation != nil)
    {
        typeof(self) __weak weakself = self;
        self.operation.thumbnailLoadBlock = ^(CPSThumbnailGeneratorOperation *op, UIImage *result)
        {
            [weakself imageLoadCompletedWithImage:result forOperation:op];
        };
        
        [[self.class thumbnailOperationQueue] addOperation:self.operation];
    }
}

- (void)imageLoadCompletedWithImage:(UIImage *)image
                       forOperation:(CPSThumbnailGeneratorOperation *)operation
{
    if (image != nil)
    {
        [[self.class thumbnailCache] setObject:image forKey:operation.filePath];
    }
    
    if (operation == self.operation)
    {
        [self setImage:image animated:YES];
        self.operation = nil;
    }
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setImage:(UIImage *)image
{
    [self setImage:image animated:NO];
}

- (void)setImage:(UIImage *)image animated:(BOOL)animated
{
    [UIView transitionWithView:self.imageView
                      duration:animated ? 0.2 : 0.0
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^
                    {
                        self.imageView.image = image;
                    }
                    completion:nil];
}

- (void)setAssetPath:(NSString *)assetPath type:(CPSFileAssetType)type
{
    UIImage *cachedImage = [[self.class thumbnailCache] objectForKey:assetPath];
    if (cachedImage == nil)
    {
        [self loadThumbnailForAssetPath:assetPath type:type];
    }
    else
    {
        [self setImage:cachedImage];
    }
}

@end
