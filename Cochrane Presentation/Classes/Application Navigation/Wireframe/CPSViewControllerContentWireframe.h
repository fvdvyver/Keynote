//
//  CPSViewControllerContentWireframe.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/18.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSRootWireframe.h"
#import "CPSMenuWireframe.h"

#import "CPSViewControllerProvider.h"

/**
 *  This class embodies a list of view controller content providers, and can navigate between them. 
 *  When the content provider of this class is set using -setContentControllerProvider:, it simply passes the message on to its parent wireframe, allowing a chain of wireframes to be created
 */
@interface CPSViewControllerContentWireframe : NSObject <CPSContentWireframe, CPSViewControllerProvider>

@property (nonatomic, weak) id<CPSContentWireframe> parentWireframe;

// This array must contain objects conforming to CPSViewControllerProvider
@property (nonatomic, copy)     NSArray *  contentProviders;
@property (nonatomic, readonly) NSUInteger currentContentProviderIndex;

@end
