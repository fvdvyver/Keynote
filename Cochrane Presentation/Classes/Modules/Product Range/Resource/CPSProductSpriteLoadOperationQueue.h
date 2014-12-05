//
//  CPSProductSpriteLoadOperationQueue.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSProductSpriteLoadOperation.h"

/**
 *  This operation queue will aggregate the results of CPSProductSpriteLoadOperation instances. These are the only types of operation this queue will accept.
 *
 *  Note: 
 *  This operation queue will use the resultCompletionBlock of any CPSProductSpriteLoadOperations added to it, overriding any previous blocks set.
 */
@interface CPSProductSpriteLoadOperationQueue : NSOperationQueue

// Calling this will return all sprite maps that have been aggregated from complete operations so far
- (NSDictionary *)productSpriteMaps;

@end
