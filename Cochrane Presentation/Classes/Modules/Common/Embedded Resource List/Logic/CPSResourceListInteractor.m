//
//  CPSResourceListInteractor.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceListInteractor.h"

#import "CPSResourceDirectory.h"
#import "CPSFileAssetItem.h"

#import "CPSBaseWireframe.h"

@implementation CPSResourceListInteractor

- (void)requestAllResourceItems
{
    [self.presenter setResourceDirectories:self.resourceDirectories];
}

- (void)itemSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    CPSResourceDirectory *directory = self.resourceDirectories[indexPath.section];
    CPSFileAssetItem *resourceItem = directory.contentFiles[indexPath.row];
    
    [self.wireframe showResource:resourceItem withDirectory:directory];
}

@end
