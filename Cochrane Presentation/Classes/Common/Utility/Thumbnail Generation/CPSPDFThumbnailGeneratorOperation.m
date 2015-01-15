//
//  CPSPDFThumbnailGeneratorOperation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSPDFThumbnailGeneratorOperation.h"

@implementation CPSPDFThumbnailGeneratorOperation

- (void)main
{
    NSURL* pdfFileUrl = [NSURL fileURLWithPath:self.filePath];
    CGPDFDocumentRef pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfFileUrl);
    
    size_t pageCount = CGPDFDocumentGetNumberOfPages(pdf);
    if (pageCount > 0)
    {
        CGPDFPageRef page = CGPDFDocumentGetPage(pdf, 1);//for the first  page
        CGRect aRect = CGPDFPageGetBoxRect(page, kCGPDFCropBox);
        UIGraphicsBeginImageContextWithOptions(aRect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, 0.0, aRect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextTranslateCTM(context, -(aRect.origin.x), -(aRect.origin.y));
        
        CGContextSetGrayFillColor(context, 1.0, 1.0);
        CGContextFillRect(context, aRect);
        
        CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, aRect, 0, false);
        CGContextConcatCTM(context, pdfTransform);
        CGContextDrawPDFPage(context, page);
        
        UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        CGContextRestoreGState(context);
        UIGraphicsEndImageContext();
        CGPDFDocumentRelease(pdf);
        
        [self completeWithResultImage:[self resizeImage:thumbnail toSize:self.thumbnailSize]];
    }
}

@end
