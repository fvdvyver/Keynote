//
//  CPSKeyValueResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/24.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceLoader.h"

/**
 *  This resource loader uses KVC to load resources for a target object. Keys in the argument dictionary are treated as key paths of the target object, and the corresponding values are mapped to these key paths
 */

@interface CPSKeyValueResourceLoader : CPSResourceLoader

@end
