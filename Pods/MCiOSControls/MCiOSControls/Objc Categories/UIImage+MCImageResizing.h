//
//  UIImage+MCImageResizing.h
//  MCiOSControls
//
//  Created by Rayman Rosevear on 2014/04/09.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MCImageResizing)


// Returns a new image with the specified width and minimum height
- (UIImage *)resizedImageForThumbnailWithWidth:(CGFloat)width
									 minHeight:(CGFloat)minHeight
						  interpolationQuality:(CGInterpolationQuality)quality;

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImageInRect:(CGRect)bounds;

@end
