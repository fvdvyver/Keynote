//
//  CPSPlaceholderWireframe.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPlaceholderWireframe.h"

#import "CPSPlaceholderPresenter.h"
#import "CPSPlaceholderViewController.h"

@interface CPSPlaceholderWireframe ()

@property (nonatomic, readonly) NSString * storyboardName;

@property (nonatomic, strong) CPSPlaceholderPresenter *presenter;

@end

@implementation CPSPlaceholderWireframe

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName placeholderText:(NSString *)placeholderText
{
    CPSPlaceholderWireframe *wireframe = [self wireframeWithStoryboardName:storyboardName viewControllerID:@"PlaceholderViewController"];
    wireframe.placeholderText = placeholderText;
    
    return wireframe;
}

- (void)prepareContentViewController
{
    self.presenter.placeholderText = self.placeholderText;
}

@end
