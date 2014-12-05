//
//  CPSProductSpriteLoadOperationQueue.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductSpriteLoadOperationQueue.h"
#import <pthread.h>

#import "CPSProductSpriteLoadOperation.h"

@interface CPSProductSpriteLoadOperationQueue ()

@property (nonatomic, strong) NSMutableDictionary * resultDictionary;
@property (nonatomic, assign) pthread_mutex_t resultMutex;

- (void)setCompletionBlockForOperation:(CPSProductSpriteLoadOperation *)operation;
- (void)addImageMap:(LSImageMap *)map forName:(NSString *)name;

@end

@implementation CPSProductSpriteLoadOperationQueue

- (void)dealloc
{
    pthread_mutex_destroy(&_resultMutex);
}

- (instancetype)init
{
    if (self = [super init])
    {
        _resultDictionary = [NSMutableDictionary dictionary];
        pthread_mutex_init(&_resultMutex, NULL);
    }
    return self;
}

- (void)setCompletionBlockForOperation:(CPSProductSpriteLoadOperation *)op
{
    NSAssert([op isKindOfClass:[CPSProductSpriteLoadOperation class]],
             @"This operation queue only supports CPSProductSpriteLoadOperation operations");
    
    typeof(self) __weak weakself = self;
    op.resultCompletionBlock = ^(NSString *mapName, LSImageMap *imageMap)
    {
        [weakself addImageMap:imageMap forName:mapName];
    };
}

- (void)addOperation:(CPSProductSpriteLoadOperation *)op
{
    [self setCompletionBlockForOperation:op];
    [super addOperation:op];
}

- (void)addOperations:(NSArray *)ops waitUntilFinished:(BOOL)wait
{
    for (CPSProductSpriteLoadOperation *op in ops)
    {
        [self setCompletionBlockForOperation:op];
    }
    
    [super addOperations:ops waitUntilFinished:wait];
}

- (void)addImageMap:(LSImageMap *)map forName:(NSString *)name
{
    pthread_mutex_lock(&_resultMutex);
    self.resultDictionary[name] = map;
    pthread_mutex_unlock(&_resultMutex);
}

- (NSDictionary *)productSpriteMaps
{
    pthread_mutex_lock(&_resultMutex);
    NSDictionary *spriteMaps = [self.resultDictionary copy];
    pthread_mutex_unlock(&_resultMutex);
    
    return spriteMaps;
}

@end
