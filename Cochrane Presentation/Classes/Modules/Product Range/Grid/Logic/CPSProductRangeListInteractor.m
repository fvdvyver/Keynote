//
//  CPSProductRangeListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeListInteractor.h"
#import <MCObserver.h>

#import "CPSProductAssetItem.h"

#import "CPSProductSpriteLoadOperationQueue.h"

#define CPSPropertyString(x) NSStringFromSelector(@selector(x))

@interface CPSProductRangeListInteractor ()

@property (nonatomic, strong) MCObserver * operationQueueFinishedObserver;
@property (nonatomic, strong) CPSProductSpriteLoadOperationQueue * operationQueue;

- (void)loadImageMapsForProducts:(NSArray *)products;
- (void)enqueueSpriteLoadOperations:(NSArray *)operations;

- (void)spriteLoadOperationsFinished;

@end

@implementation CPSProductRangeListInteractor

- (void)requestData
{
    self.operationQueue = nil;
    [self loadImageMapsForProducts:self.productItems];
}

- (void)setOperationQueue:(CPSProductSpriteLoadOperationQueue *)operationQueue
{
    [self.operationQueueFinishedObserver stopObserving];
    self.operationQueueFinishedObserver = nil;
    
    [self.operationQueue cancelAllOperations];
    _operationQueue = operationQueue;
    
    if (self.operationQueue != nil)
    {
        self.operationQueueFinishedObserver = [MCObserver observerForObject:_operationQueue
                                                                    keyPath:CPSPropertyString(operationCount)
                                                                     target:self
                                                                     action:@selector(spriteLoadOperationsFinished)];
    }
}

- (void)loadImageMapsForProducts:(NSArray *)products
{
    NSMutableArray *loadOperations = [NSMutableArray arrayWithCapacity:products.count];
    for (CPSAssetItem *asset in products)
    {
        NSOperation *operation = [CPSProductSpriteLoadOperation spriteLoadOperationWithMapName:asset.primaryFilename];
        [loadOperations addObject:operation];
    }
    
    [self enqueueSpriteLoadOperations:loadOperations];
}

- (void)enqueueSpriteLoadOperations:(NSArray *)operations
{
    CPSProductSpriteLoadOperationQueue *queue = [CPSProductSpriteLoadOperationQueue new];
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperations:operations waitUntilFinished:NO];
    self.operationQueue = queue;
}

- (void)spriteLoadOperationsFinished
{
    if (![NSThread isMainThread])
    {
        [self performSelectorOnMainThread:@selector(spriteLoadOperationsFinished) withObject:nil waitUntilDone:NO];
        return;
    }
    
    if (self.operationQueue != nil && self.operationQueue.operationCount == 0)
    {   
        NSDictionary *spriteMaps = [self.operationQueue productSpriteMaps];
        self.operationQueue = nil;
        
        [self.presenter setProductItems:self.productItems withImageMapDictionary:spriteMaps];
        [self.wireframe performSelector:@selector(hideLoadingView) withObject:nil afterDelay:0.0];
    }
}

@end
