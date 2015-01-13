//
//  CPSThumbnailGeneratorOperation.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CPSFileAssetType.h"

@class CPSThumbnailGeneratorOperation;

typedef void(^CPSThumbnailLoadBlock)(CPSThumbnailGeneratorOperation *, UIImage *);

@interface CPSThumbnailGeneratorOperation : NSOperation

@property (nonatomic, readonly) NSString * filePath;
@property (nonatomic, readonly) CGSize thumbnailSize;

@property (nonatomic, copy) CPSThumbnailLoadBlock thumbnailLoadBlock;

+ (instancetype)operationWithFileType:(CPSFileAssetType)type
                             filePath:(NSString *)filePath
                                 size:(CGSize)thumbnailSize;

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;

// To be called by subclasses only
- (void)completeWithResultImage:(UIImage *)image;

@end
