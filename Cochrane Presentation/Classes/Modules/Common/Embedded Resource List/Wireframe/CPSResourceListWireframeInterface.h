//
//  CPSResourceListWireframeInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CPSFileAssetItem;
@class CPSResourceDirectory;

@protocol CPSResourceListWireframeInterface <NSObject>

- (void)showResource:(CPSFileAssetItem *)resourceItem withDirectory:(CPSResourceDirectory *)directory;

@end
