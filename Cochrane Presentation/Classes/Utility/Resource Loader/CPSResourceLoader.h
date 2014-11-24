//
//  CPSResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  This is an abstract base class used for loading resources for a source object. Specific subclasses should do the work of actually loading the resources however they see fit.
 */

@interface CPSResourceLoader : NSObject

@property (nonatomic, strong) id targetObject;
@property (nonatomic, strong) NSDictionary * arguments;

- (void)loadResources;

@end
