//
//  CPSProductSpriteLoadOperation.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/04.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductSpriteLoadOperation.h"

#import "LSImageMap.h"

@implementation CPSProductSpriteLoadOperation

+ (instancetype)spriteLoadOperationWithMapName:(NSString *)mapName
{
    CPSProductSpriteLoadOperation *operation = [[self class] new];
    operation->_mapName = mapName;
    
    return operation;
}

- (void)main
{
    @autoreleasepool
    {
        NSParameterAssert(self.resultCompletionBlock);
        
        LSImageMap *imageMap = [LSImageMap imageMapWithContentsOfFile:self.mapName];
        self.resultCompletionBlock(self.mapName, imageMap);
    }
}

@end
