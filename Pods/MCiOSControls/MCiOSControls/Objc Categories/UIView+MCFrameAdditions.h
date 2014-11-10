//
//  UIView+MCFrameAdditions.h
//
//  Created by Rayman Rosevear on 2012/09/04.
//
//

#import <UIKit/UIKit.h>

/**
 *	UIView frame additions that help keep code more readable
 */

@interface UIView (MCFrameAdditions)

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height; // normal rect properties
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom; // these will stretch/shrink the rect

@end
