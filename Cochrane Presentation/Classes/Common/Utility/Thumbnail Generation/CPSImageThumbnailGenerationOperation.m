//
//  CPSImageThumbnailGenerationOperation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSImageThumbnailGenerationOperation.h"

@implementation CPSImageThumbnailGenerationOperation

- (void)main
{
    NSData *imageData = [NSData dataWithContentsOfFile:self.filePath];
    UIImage *thumbnail = [UIImage imageWithData:imageData scale:[[UIScreen mainScreen] scale]];
    [self completeWithResultImage:[self resizeImage:thumbnail toSize:self.thumbnailSize]];
}

@end
