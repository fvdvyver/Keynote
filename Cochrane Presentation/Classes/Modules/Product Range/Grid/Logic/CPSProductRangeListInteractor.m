//
//  CPSProductRangeListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/01.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSProductRangeListInteractor.h"

#import "CPSProductAssetItem.h"

#import "LSImageMap.h"

@interface CPSProductRangeListInteractor ()

- (void)loadImageMapsAsyncWithCompletion:(void (^)(NSArray *products, NSDictionary *maps))completion;


@end

@implementation CPSProductRangeListInteractor

- (void)requestData
{
    typeof(self) __weak weakself = self;
    [self loadImageMapsAsyncWithCompletion:^(NSArray *products, NSDictionary *maps)
    {
        typeof(weakself) __strong strongself = weakself;
        
        [strongself.presenter setProductItems:products withImageMapDictionary:maps];
        [strongself.wireframe performSelector:@selector(hideLoadingView) withObject:nil afterDelay:0.0];
    }];
}

- (void)loadImageMapsAsyncWithCompletion:(void (^)(NSArray *, NSDictionary *))completion
{
    NSArray *products = self.productItems;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
    {
        NSMutableDictionary *imageMaps = [NSMutableDictionary dictionaryWithCapacity:products.count];
        for (CPSProductAssetItem *item in products)
        {
            NSString *mapName = item.primaryFilename;
            LSImageMap *imageMap = [LSImageMap imageMapWithContentsOfFile:mapName];
            
            if (imageMap == nil)
            {
                NSLog(@"WARNING: sprite map (%@) for product %@ not found", mapName, item.title);
            }
            else
            {
                imageMaps[mapName] = imageMap;
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            completion(products, imageMaps);
        });
    });
}

@end
