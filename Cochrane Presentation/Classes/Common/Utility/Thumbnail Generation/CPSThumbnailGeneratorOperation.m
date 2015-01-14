//
//  CPSThumbnailGeneratorOperation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSThumbnailGeneratorOperation.h"

#import "CPSImageThumbnailGenerationOperation.h"
#import "CPSVideoThumbnailGenerationOperation.h"
#import "CPSPDFThumbnailGeneratorOperation.h"

#import <UIImage+MCImageResizing.h>

@interface CPSThumbnailGeneratorOperation ()

@property (nonatomic, strong) NSString * path;
@property (nonatomic, assign) CGSize size;

@end

@implementation CPSThumbnailGeneratorOperation

+ (instancetype)operationWithFileType:(CPSFileAssetType)type
                             filePath:(NSString *)filePath
                                 size:(CGSize)thumbnailSize
{
    NSDictionary *classMap = @{
                               @(CPSFileAssetTypeImage) : [CPSImageThumbnailGenerationOperation class],
                               @(CPSFileAssetTypeVideo) : [CPSVideoThumbnailGenerationOperation class],
                               @(CPSFileAssetTypePDF)   : [CPSPDFThumbnailGeneratorOperation class]
                               };
    
    Class cls = classMap[@(type)];
    CPSThumbnailGeneratorOperation *operation = [cls new];
    operation.path = filePath;
    operation.size = thumbnailSize;
    
    return operation;
}

- (NSString *)filePath
{
    return _path;
}

- (CGSize)thumbnailSize
{
    return _size;
}

- (void)main
{
    NSAssert(NO, @"%@ is abstract. A concrete subclass should be used instead", NSStringFromClass(self.class));
}

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    return [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                       bounds:size
                         interpolationQuality:kCGInterpolationHigh];
}

- (void)completeWithResultImage:(UIImage *)image
{
    if (!self.cancelled && self.thumbnailLoadBlock != nil && image != nil)
    {
        if ([NSThread isMainThread])
        {
            self.thumbnailLoadBlock(self, image);
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                self.thumbnailLoadBlock(self, image);
            });
        }
    }
}

@end
