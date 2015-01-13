//
//  CPSResourceListInteractor.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSResourceListWireframeInterface.h"
#import "CPSResourceListInteractorIO.h"

@class CPSResourceDirectory;

@interface CPSResourceListInteractor : NSObject <CPSResourceListInteractorInput>

@property (nonatomic, weak)   CPSBaseWireframe<CPSResourceListWireframeInterface> * wireframe;
@property (nonatomic, strong) id<CPSResourceListInteractorOutput> presenter;

@property (nonatomic, strong) NSArray * resourceDirectories;

@end
