//
//  CPSCostOfRiskResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCostOfRiskResourceLoader.h"

#import <KZPropertyMapper/KZPropertyMapper.h>

#import "CPSCostOfRiskItem.h"

@interface CPSCostOfRiskResourceLoader ()

- (NSDictionary *)itemMapping;

@end

@implementation CPSCostOfRiskResourceLoader

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
    
    NSDictionary *itemMapping = [self itemMapping];
    
    for (NSDictionary *sourceItem in datasourceArray)
    {
        CPSCostOfRiskItem *item = [CPSCostOfRiskItem new];
        [KZPropertyMapper mapValuesFrom:sourceItem
                             toInstance:item
                           usingMapping:itemMapping];
        
        [datasource addObject:item];
    }
    
    [self.targetObject setValue:datasource forKeyPath:datasourceKeypath];
}

- (NSDictionary *)itemMapping
{
    return @{
             @"title_text" : @"titleText",
             @"video_file" : @"videoFile"
             };
}

@end
