//
//  CPSVideoListResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <KZPropertyMapper/KZPropertyMapper.h>

#import "CPSVideoListResourceLoader.h"
#import "CPSVideoListItem.h"

@implementation CPSVideoListResourceLoader

- (void)loadResources
{
    NSString *datasourceKeypath = self.arguments[@"datasource_keypath"];
    NSString *dataSourceFile = self.arguments[@"data_file"];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:dataSourceFile ofType:@"plist"];
    
    NSAssert(datasourceKeypath != nil, @"%@ needs the keypath of the datasource array on the target object to be set", self.class);
    NSAssert(filepath != nil, @"%@ needs a valid resource data_file (%@ was given)",
             NSStringFromClass(self.class), dataSourceFile);
    
    NSArray *datasourceArray = [NSArray arrayWithContentsOfFile:filepath];
    NSMutableArray *datasource = [NSMutableArray arrayWithCapacity:datasourceArray.count];
    
    NSDictionary *itemMapping = [self videoListItemMapping];
    
    for (NSDictionary *sourceItem in datasourceArray)
    {
        CPSVideoListItem *newItem = [[self videoListItemClass] new];
        [KZPropertyMapper mapValuesFrom:sourceItem
                             toInstance:newItem
                           usingMapping:itemMapping];
        
        [datasource addObject:newItem];
    }
    
    [self.targetObject setValue:datasource forKeyPath:datasourceKeypath];
}

- (Class)videoListItemClass
{
    return [CPSVideoListItem class];
}

- (NSDictionary *)videoListItemMapping
{
    return @{
             @"title_text" : @"titleText",
             @"video_file" : @"videoFilename"
             };
}

@end
