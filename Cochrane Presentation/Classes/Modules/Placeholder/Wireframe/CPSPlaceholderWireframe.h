//
//  CPSPlaceholderWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSViewControllerProvider.h"
#import "CPSContentWireframe.h"

@interface CPSPlaceholderWireframe : NSObject <CPSViewControllerProvider, CPSSubContentWireframe>

@property (nonatomic, weak) id<CPSContentWireframe> parentContentWireframe;

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName placeholderText:(NSString *)placeholderText;

@end
