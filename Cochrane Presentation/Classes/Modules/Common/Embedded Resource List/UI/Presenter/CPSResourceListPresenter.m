//
//  CPSResourceListPresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import "CPSResourceListPresenter.h"

#import "CPSResourceDirectoryListDataProvider.h"

@interface CPSResourceListPresenter ()

@property (nonatomic, strong) CPSResourceDirectoryListDataProvider * dataProvider;

@end

@implementation CPSResourceListPresenter

@synthesize wireframe = _wireframe;

- (void)updateView
{
    [self.interactor requestAllResourceItems];
}

- (void)setResourceDirectories:(NSArray *)resourceDirectories
{
    self.dataProvider = [CPSResourceDirectoryListDataProvider providerWithResourceDirectories:resourceDirectories];
    [self.userInterface setResourceListDataProvider:self.dataProvider];
}

- (void)itemSelectedAtIndexPath:(NSIndexPath *)indexPath
{
    [self.interactor itemSelectedAtIndexPath:indexPath];
}

@end
