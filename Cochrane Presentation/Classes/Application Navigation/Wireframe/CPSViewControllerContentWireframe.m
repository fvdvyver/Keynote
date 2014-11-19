//
//  CPSViewControllerContentWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/18.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSViewControllerContentWireframe.h"

@interface CPSViewControllerContentWireframe ()

@property (nonatomic, assign, readwrite) NSUInteger currentContentProviderIndex;

@end

@implementation CPSViewControllerContentWireframe

- (void)setContentProviders:(NSArray *)contentProviders
{
    _contentProviders = [contentProviders copy];
    self.currentContentProviderIndex = 0;
}

- (void)advanceCurrentContentProvider
{
    if (self.currentContentProviderIndex < self.contentProviders.count - 1)
    {
        [self setContentControllerProvider:self.contentProviders[++self.currentContentProviderIndex]];
    }
    else
    {
        [self.parentContentWireframe advanceCurrentContentProvider];
    }
}

- (void)setContentControllerProvider:(id<CPSViewControllerProvider>)contentControllerProvider
{
    [self.parentContentWireframe setContentControllerProvider:contentControllerProvider];
}

- (UIViewController *)contentViewController
{
    id<CPSViewControllerProvider> provider = self.contentProviders[self.currentContentProviderIndex];
    return [provider contentViewController];
}

@end
