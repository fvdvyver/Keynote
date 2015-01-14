//
//  MCArrayQuickLookPreviewDataSource.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@interface MCArrayQuickLookPreviewDataSource : NSObject <QLPreviewControllerDataSource>

@property (nonatomic, strong) NSArray *filePaths;

@end
