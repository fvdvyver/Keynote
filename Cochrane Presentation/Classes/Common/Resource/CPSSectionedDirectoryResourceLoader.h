//
//  CPSSectionedDirectoryResourceLoader.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/12.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSPropertyMappingResourceLoader.h"

@class CPSFileAssetItem;
@class CPSResourceDirectory;

/**
 *  For each element in the array this resource loader maps, an extra array will be created for a list of sections, each containing a list of resources which are read from a directory
 *
 *  The arguments must include:
 *      ∙ The arguments required by the superclass
 *      ∙ The relative path prefix of the resources to be loaded by this resource loader (key => `resource_path_prefix')
 *      ∙ The key path of the property to assign the resulting sectioned data to (key => `sectioned_data_keypath')
 *
 *  Furthermore, to have any resources of a data item loaded, the data to be used for each item in the file specified by the `data_file' key (superclass requirement), must have the following structure:
 *      ∙ There must be a dictionary that specifies the path and sections (key => `resource')
 *          ∙ This dictionary must have string directory property, which gets appended to the `resource_path_prefix' (key => `directory')
 *          ∙ There must be an array of strings, each specifying a folder name for the section title (key => `sections')
 *
 */
@interface CPSSectionedDirectoryResourceLoader : CPSPropertyMappingResourceLoader

- (void)loadSectionedResourcesForTargetItem:(id)target
                      resourceSpecification:(NSDictionary *)resource;

/**
 *  This will return an array of CPSResourceDirectory. Its contentFiles array will contain instances of whatever object is returned from -assetFromPath: (default is CPSFileAssetItem)
 */
- (CPSResourceDirectory *)loadResourcesAtDirectory:(NSString *)path;
- (id)assetFromPath:(NSString *)path;

@end
