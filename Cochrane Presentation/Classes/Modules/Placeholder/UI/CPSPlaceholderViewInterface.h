//
//  CPSPlaceholderViewInterface.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/14.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CPSPlaceholderViewEventHandler <NSObject>

- (void)updateView;

@end

@protocol CPSPlaceholderViewInterface <NSObject>

- (void)setPlacholderText:(NSString *)placeholderText;

@end
