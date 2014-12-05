//
//  CPSProductSpriteLoadOperation.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSImageMap;

/**
 *  This operation will load the sprite image map resources for a single product.
 */
@interface CPSProductSpriteLoadOperation : NSOperation

@property (nonatomic, readonly) NSString * mapName;

// This may not be called on the main thread
@property (nonatomic, copy) void (^resultCompletionBlock)(NSString *mapName, LSImageMap *resultImageMap);

+ (instancetype)spriteLoadOperationWithMapName:(NSString *)mapName;

@end
