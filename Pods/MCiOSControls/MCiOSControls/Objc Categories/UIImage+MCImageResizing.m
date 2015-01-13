//
//  UIImage+MCImageResizing.m
//  MCiOSControls
//
//  Created by Rayman Rosevear on 2014/04/09.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "UIImage+MCImageResizing.h"

@implementation UIImage (MCImageResizing)

- (UIImage *)resizedImageForThumbnailWithWidth:(CGFloat)width
									 minHeight:(CGFloat)minHeight
						  interpolationQuality:(CGInterpolationQuality)quality
{
	CGSize newSize = self.size;
	if (newSize.width != width)
	{
		newSize.height *= width / self.size.width;
		newSize.width = width;
	}
	if (newSize.height < minHeight)
	{
		newSize.height = minHeight;
	}
	
	UIImage *newImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
												   bounds:newSize
									 interpolationQuality:kCGInterpolationLow];
	
	if (newImage.size.width > ceilf(newSize.width))
	{
		// The image needs to be cropped
		CGRect cropRect = CGRectMake(round((newImage.size.width - newSize.width) / 2),
									 round((newImage.size.height - newSize.height) / 2),
									 newSize.width,
									 newSize.height);
		newImage = [newImage croppedImageInRect:cropRect];
	}
	
	return newImage;
}

- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality
{
    BOOL drawTransposed;
    
    switch (self.imageOrientation)
	{
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
		{
            drawTransposed = YES;
            break;
		}
        default:
		{
            drawTransposed = NO;
		}
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width * self.scale,
                                                newRect.size.height * self.scale,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Scale, then Rotate and/or flip the image if required by its orientation
	CGContextConcatCTM(bitmap, CGAffineTransformMakeScale(self.scale, self.scale));
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:self.scale orientation:UIImageOrientationUp];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality
{
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode)
	{
        case UIViewContentModeScaleAspectFill:
		{
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
		}
        case UIViewContentModeScaleAspectFit:
		{
			ratio = MIN(horizontalRatio, verticalRatio);
            break;
		}
        default:
		{
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)contentMode];
		}
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    CGRect cropRect = CGRectMake(floor((newSize.width - bounds.width) / 2.0),
                                 floor((newSize.height - bounds.height) / 2.0),
                                 bounds.width,
                                 bounds.height);
    return [[self resizedImage:newSize interpolationQuality:quality] croppedImageInRect:cropRect];
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
		{
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
		}
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
		{
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
		}
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
		{
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
		}
		default:
			break;
    }
    
    switch (self.imageOrientation)
	{
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
		{
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
		}
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
		{
			transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
		}
		default:
			break;
    }
    
    return transform;
}

- (UIImage *)croppedImageInRect:(CGRect)bounds
{
	if (self.scale != 1.0f)
	{
        bounds = CGRectMake(bounds.origin.x * self.scale,
                            bounds.origin.y * self.scale,
                            bounds.size.width * self.scale,
                            bounds.size.height * self.scale);
    }
	
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    return croppedImage;
}

@end
