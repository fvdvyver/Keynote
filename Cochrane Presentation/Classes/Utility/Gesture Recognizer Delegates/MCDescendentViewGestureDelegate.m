//
//  MCDescendentViewGestureDelegate.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/25.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "MCDescendentViewGestureDelegate.h"

@implementation MCDescendentViewGestureDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (self.allowTouchesOnBaseView && touch.view == self.baseView)
    {
        return YES;
    }
    
    return ![touch.view isDescendantOfView:self.baseView];
}

@end
