//
//  CPSAccessPagePresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSPresenter.h"
#import "CPSBaseWireframe.h"

#import "CPSAccessPageInterface.h"

@interface CPSAccessPagePresenter : NSObject <CPSPresenter, CPSAccessPageEventHandler>

@property (nonatomic, weak) CPSBaseWireframe * wireframe;

@end
