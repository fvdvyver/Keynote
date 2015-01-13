//
//  CPSResourceDirectoryListDataProvider.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceDirectoryListDataProvider.h"

#import "CPSFileAssetItem.h"

@interface CPSResourceDirectoryListDataProvider ()

@property (nonatomic, strong, readwrite) NSArray * resourceDirectories;

@end

@implementation CPSResourceDirectoryListDataProvider

+ (instancetype)providerWithResourceDirectories:(NSArray *)resourceDirectories
{
    CPSResourceDirectoryListDataProvider *provider = [[self class] new];
    provider.resourceDirectories = resourceDirectories;
    
    return provider;
}

- (NSInteger)numberOfSections
{
    return [self.resourceDirectories count];
}

- (NSInteger)numberOfItemsInSection:(NSInteger)sectionIdx
{
    CPSResourceDirectory *directory = self.resourceDirectories[sectionIdx];
    return directory.contentFiles.count;
}

- (NSString *)titleForSection:(NSInteger)sectionIdx
{
    CPSResourceDirectory *directory = self.resourceDirectories[sectionIdx];
    return [directory.directoryName uppercaseString];
}

- (CPSFileAssetItem *)itemAtIndexPath:(NSIndexPath *)indexPath
{
    CPSResourceDirectory *directory = self.resourceDirectories[indexPath.section];
    return directory.contentFiles[indexPath.row];
}

- (UIImage *)thumbnailForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIImage imageNamed:@"AppIcon"];
}

- (NSString *)titleForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CPSFileAssetItem *asset = [self itemAtIndexPath:indexPath];
    return [[asset.path lastPathComponent] stringByDeletingPathExtension];
}

@end
