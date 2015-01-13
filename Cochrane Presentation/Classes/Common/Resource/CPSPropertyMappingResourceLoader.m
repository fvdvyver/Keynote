//
//  CPSPropertyMappingResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPropertyMappingResourceLoader.h"

#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation CPSPropertyMappingResourceLoader

- (void)loadResources
{
    [KZPropertyMapper logIgnoredValues:NO];
    
    NSString *datasourceKeypath = self.arguments[@"target_data_keypath"];
    NSString *dataSourceFile = self.arguments[@"data_file"];
    NSString *mappingFile = self.arguments[@"mapping"];
    NSString *classString = self.arguments[@"instance_class"];
    
    NSString *datapath = [[NSBundle mainBundle] pathForResource:dataSourceFile ofType:@"plist"];
    NSString *mappingPath = [[NSBundle mainBundle] pathForResource:mappingFile ofType:@"plist"];
    Class instanceClass = NSClassFromString(classString);
    
    NSAssert(datasourceKeypath != nil,
             @"%@ needs the key path of the mapped data array on the target object to be set", NSStringFromClass(self.class));
    NSAssert(datapath != nil, @"%@ needs a valid resource data_file (%@ was given)",
             NSStringFromClass(self.class), dataSourceFile);
    NSAssert(mappingPath, @"%@ needs a valid mapping file (%@ was given)",
             NSStringFromClass(self.class), mappingFile);
    NSAssert(instanceClass != nil, @"%@ needs the class of the instances to map to to be set",
             NSStringFromClass(self.class));
    
    NSArray *datasourceArray = [NSArray arrayWithContentsOfFile:datapath];
    NSDictionary *itemMapping = [NSDictionary dictionaryWithContentsOfFile:mappingPath];
    
    NSMutableArray *mappedArray = [NSMutableArray arrayWithCapacity:datasourceArray.count];
    
    for (NSDictionary *sourceItem in datasourceArray)
    {
        id newItem = [self newMappedItemFromSource:sourceItem
                                  destinationClass:instanceClass
                                       withMapping:itemMapping];
        
        [mappedArray addObject:newItem];
    }
    
    [self.targetObject setValue:mappedArray forKeyPath:datasourceKeypath];
}

- (id)newMappedItemFromSource:(NSDictionary *)sourceItem
             destinationClass:(Class)destinationClass
                  withMapping:(NSDictionary *)itemMapping
{
    id newItem = [destinationClass new];
    [KZPropertyMapper mapValuesFrom:sourceItem
                         toInstance:newItem
                       usingMapping:itemMapping];
    
    return newItem;
}

@end
