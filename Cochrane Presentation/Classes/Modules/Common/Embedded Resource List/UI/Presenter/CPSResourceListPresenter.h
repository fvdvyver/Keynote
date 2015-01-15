//
//  CPSResourceListPresenter.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2015/01/13.
//  Copyright (c) 2015 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CPSResourceListInteractorIO.h"
#import "CPSResourceListView.h"

@interface CPSResourceListPresenter : NSObject <CPSResourceListInteractorOutput, CPSResourceListViewEventHandler>

@property (nonatomic, weak) id <CPSResourceListInteractorInput> interactor;
@property (nonatomic, weak) id <CPSResourceListView> userInterface;

@property (nonatomic, assign) BOOL hidesBackground;
@property (nonatomic, strong) NSString *viewInsetsString;

@end
