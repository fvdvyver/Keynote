//
//  CPSAccessPageInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/19.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSPresenter.h"

@protocol CPSAccessPageEventHandler <CPSPresenter>

- (void)accessTapped;

@end
