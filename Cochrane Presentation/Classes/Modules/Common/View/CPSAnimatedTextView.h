//
//  CPSAnimatedTextView.h
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/26.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Custom text view that can animate its text to try match the animation used by the Cochrane keynote presentation.
 */
@interface CPSAnimatedTextView : UITextView

/**
 *  When non nil, any text set will be attributed using these attributes
 */
@property (nonatomic, strong) NSDictionary * textAttributes;

/**
 *  Begin the text animation using the default letter rate, which is dependent on the length of the text to animate and the duration given
 *
 *  @param  duration    the total duration of the animation
 */
- (void)animateTextWithDuration:(CGFloat)duration;
/**
 *  Begin the text animation. The text parameter of the text view is adjusted periodically, but the original text can be obtained with the -originalText method.
 *
 *  @param  duration    the total duration of the animation
 *  @param  letterRate  the number of times per second the text view is updated
 */
- (void)animateTextWithDuration:(CGFloat)duration letterRate:(CGFloat)rate;

/**
 *  Ends the animation if one is currently running
 */
- (void)stopAnimating;

- (NSString *)originalText;

@end
