//
//  CPSResourceDirectory+FileTypeAdditions.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/14.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceDirectory.h"

#import "CPSFileAssetItem+MIME.h"

/**
 *  This category assumes the contentFiles array contains CPSFileAssetItem instances, and that their fileType property is correctly set
 */
@interface CPSResourceDirectory (FileTypeAdditions)

- (NSArray *)filePathsForAllImages;

@end
