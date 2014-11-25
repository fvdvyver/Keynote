//
//  MCDescendentViewGestureDelegate.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  This gesture recogniser delegate will only allow the gesture to begin if it does not originate from the descendent of a specified view.
 */
@interface MCDescendentViewGestureDelegate : NSObject <UIGestureRecognizerDelegate>

/**
 *  Any touches that originate from a descendent of this view will not cause the gesture to be recognized
 */
@property (nonatomic, strong) UIView * baseView;

/**
 *  If this is yes, then touches can cause the gesture to be recognised if they origniate from the baseView, but not on a descendent view
 */
@property (nonatomic, assign) BOOL allowTouchesOnBaseView;

@end
