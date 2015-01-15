//
//  CPSResourceListDirectoryResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceLoader.h"

/**
 *  This resource loader will load an array of sections from a specified directory. Each directory at this path will be enumerated, with a CPSResourceDirectory created. Each CPSResourceDirectory created will be populated with the contents of the directory correlating to the CPSResourceDirectory instance.
 *
 *  The arguments must include:
 *      ∙ the base directory to be enumerated (key => `base_directory')
 *      ∙ the key path of the property to assign the resulting array of CPSResourceDirectory instances to (key => `target_data_keypath')
 */
@interface CPSResourceListDirectoryResourceLoader : CPSResourceLoader

@end
