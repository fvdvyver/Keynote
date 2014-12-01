//
//  CPSViewControllerMenuItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSViewControllerMenuItem.h"

@interface CPSViewControllerMenuItem ()

@property (nonatomic, readonly) id<CPSViewControllerProvider> viewControllerProvider;

@end

@implementation CPSViewControllerMenuItem

@synthesize viewControllerProvider = _viewControllerProvider;

- (instancetype)initWithIdentifier:(NSString *)identifier
                             title:(NSString *)title
                              icon:(UIImage *)icon
            viewControllerProvider:(id<CPSViewControllerProvider>)viewControllerProvider
{
    if (self = [super initWithIdentifier:identifier title:title icon:icon])
    {
        _viewControllerProvider = viewControllerProvider;
    }
    return self;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] alloc] initWithIdentifier:self.identifier
                                              title:self.title
                                               icon:self.iconImage
                             viewControllerProvider:self.viewControllerProvider];
}

- (NSUInteger)hash
{
    NSInteger prime = 31;
    NSUInteger hash = 1;
    
    hash = self.title == nil ? hash : (prime * hash + [self.title hash]);
    hash = prime * hash + ((int) self.iconImage);
    hash = prime * hash + ((int) self.viewControllerProvider);
    
    return hash;
}

- (BOOL)isEqualToMenuItem:(CPSViewControllerMenuItem *)otherItem
{
    if (otherItem == nil)
    {
        return NO;
    }
    
    if (otherItem == self)
    {
        return YES;
    }
    
    if (![self.title isEqualToString:otherItem.title])
    {
        return NO;
    }
    if (self.iconImage != otherItem.iconImage)
    {
        return NO;
    }
    if (self.viewControllerProvider != otherItem.viewControllerProvider)
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }
    if (![object isKindOfClass:[CPSViewControllerMenuItem class]])
    {
        return NO;
    }
    
    return [self isEqualToMenuItem:object];
}

@end
