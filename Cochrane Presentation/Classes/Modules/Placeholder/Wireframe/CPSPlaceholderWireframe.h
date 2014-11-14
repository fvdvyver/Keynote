//
//  CPSPlaceholderWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSViewControllerProvider.h"

@interface CPSPlaceholderWireframe : NSObject <CPSViewControllerProvider>

+ (instancetype)wireframeWithStoryboardName:(NSString *)storyboardName placeholderText:(NSString *)placeholderText;

@end
