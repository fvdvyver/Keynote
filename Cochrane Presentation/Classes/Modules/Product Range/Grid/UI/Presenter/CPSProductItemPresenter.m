//
//  CPSProductItemPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductItemPresenter.h"

#import "CPSProductAssetItem.h"
#import "LSImageMap.h"

@interface CPSProductItemPresenter ()

@property (nonatomic, strong) NSMutableDictionary * spriteMapDict;

- (LSImageMap *)spriteMapWithName:(NSString *)name;

@end

@implementation CPSProductItemPresenter

- (instancetype)init
{
    if (self = [super init])
    {
        _spriteMapDict = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)configureVideoView:(id<CPSProductItemVideoView>)view withItem:(CPSProductAssetItem *)item
{
    LSImageMap *spriteMap = [self spriteMapWithName:item.primaryFilename];
    
    [view setTitle:item.title];
    [view setSpriteMap:spriteMap];
}

- (LSImageMap *)spriteMapWithName:(NSString *)name
{
    LSImageMap *map = self.spriteMapDict[name];
    if (map == nil)
    {
        map = [LSImageMap imageMapWithContentsOfFile:name];
        if (map == nil)
        {
            NSLog(@"WARNING: sprite map (%@) for product not found", name);
        }
        else
        {
            self.spriteMapDict[name] = map;
        }
    }
    
    return map;
}

@end
