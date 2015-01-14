//
//  MCArrayQuickLookPreviewDataSource.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "MCArrayQuickLookPreviewDataSource.h"

@implementation MCArrayQuickLookPreviewDataSource

- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller;
{
    return self.filePaths.count;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index
{
    NSString *path = self.filePaths[index];
    return [NSURL fileURLWithPath:path];
}

@end
