//
//  CPSAccessPagePresenter.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAccessPagePresenter.h"

#import "CPSBaseWireframe.h"

@implementation CPSAccessPagePresenter

@synthesize wireframe = _wireframe;
@synthesize interactor = _interactor;
@synthesize userInterface = _userInterface;

- (void)accessTapped
{
    [self.wireframe advanceCurrentContentProvider];
}

@end
