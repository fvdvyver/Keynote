//
//  CPSResourceDirectoryListDataProvider.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSResourceDirectory.h"
#import "CPSResourceListDataProvider.h"

@class CPSFileAssetItem;

@interface CPSResourceDirectoryListDataProvider : NSObject <CPSResourceListDataProvider>

@property (nonatomic, readonly) NSArray *resourceDirectories;

+ (instancetype)providerWithResourceDirectories:(NSArray *)resourceDirectories;

- (CPSFileAssetItem *)itemAtIndexPath:(NSIndexPath *)indexPath;

@end
