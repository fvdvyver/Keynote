//
//  CPSAccessPagePresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAccessPagePresenter.h"

@implementation CPSAccessPagePresenter

@synthesize userInterface = _userInterface;

- (void)accessTapped
{
    [self.wireframe advanceCurrentContentProvider];
}

@end
