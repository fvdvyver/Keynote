//
//  CPSPropertyMappingResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/27.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceLoader.h"

/**
 *  This resource loader will load an array of values from a property list file, and map each value into an instance of the class specified.
 *
 *  The arguments must include:
 *      ∙ the class of the item values will be mapped into (key => `instance_class')
 *      ∙ the name of a plist file specifying the mapping (key => `mapping')
 *      ∙ the name of a plist file specifying the array of values(key => `data_file'
 *      ∙ the key path of the property to assign the resulting array of mapped values to (key => `target_data_keypath')
 */
@interface CPSPropertyMappingResourceLoader : CPSResourceLoader

- (id)newMappedItemFromSource:(NSDictionary *)sourceItem
            destinationClass:(Class)destinationClass
                 withMapping:(NSDictionary *)itemMapping;

@end
