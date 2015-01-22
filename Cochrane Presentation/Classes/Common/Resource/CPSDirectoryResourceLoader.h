//
//  CPSDirectoryResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/22.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSPropertyMappingResourceLoader.h"

/**
 *  For each element in the array this resource loader maps, an extra array will be created for a list of resources which are read from a directory. The list loaded is returned as an array of absolute string file paths
 *
 *  The arguments must include:
 *      ∙ The arguments required by the superclass
 *      ∙ The relative path prefix of the resources to be loaded by this resource loader (key => `resource_path_prefix')
 *      ∙ The key path of the property to assign the resulting list data to (key => `resource_data_list_keypath')
 *
 *  Furthermore, to have any resources of a data item loaded, the data to be used for each item in the file specified by the `data_file' key (superclass requirement), must have the following structure:
 *      ∙ There must be a string which specifies the folder name to read resources from (key => `directory')
 *
 */
@interface CPSDirectoryResourceLoader : CPSPropertyMappingResourceLoader

- (void)loadSectionedResourcesForTargetItem:(id)target
                                inDirectory:(NSString *)directory;

@end
