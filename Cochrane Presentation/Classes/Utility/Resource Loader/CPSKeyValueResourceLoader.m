//
//  CPSKeyValueResourceLoader.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSKeyValueResourceLoader.h"

@implementation CPSKeyValueResourceLoader

- (void)loadResources
{
    NSDictionary *arguments = self.arguments;
    id target = self.targetObject;
    
    for (NSString *keyPath in [arguments allKeys])
    {
        id value = arguments[keyPath];
        [target setValue:value forKeyPath:keyPath];
    }
}

@end
