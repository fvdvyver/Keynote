//
//  CPSAnimatedTextView.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/26.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSAnimatedTextView.h"

@interface CPSAnimatedTextView ()

@property (nonatomic, strong) NSString * originalText;

@property (nonatomic, assign) CFTimeInterval animationStartTime;
@property (nonatomic, assign) CGFloat currentAnimationDuration;
@property (nonatomic, assign) CGFloat currentAnimationRate;

@property (nonatomic, strong) NSTimer * animationTimer;

- (void)scheduleTextUpdateTimer;
- (void)updateTextForTimer:(NSTimer *)timer;

- (void)updateTextAnimationWithElapsedtime:(CFTimeInterval)elapsed;
- (NSString *)interpolatedTextForIndex:(NSInteger)characterIndex inString:(NSString *)text;
- (NSString *)suffixForCharacter:(unichar)character;

@end

@implementation CPSAnimatedTextView

- (void)dealloc
{
    [self.animationTimer invalidate];
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    
    [self.animationTimer invalidate];
    self.animationTimer = nil;
}

- (void)setText:(NSString *)text
{
    [self stopAnimating];
    
    self.originalText = text;
    [super setText:text];
}

- (void)animateTextWithDuration:(CGFloat)duration
{
    [self animateTextWithDuration:duration letterRate:self.text.length / duration];
}

- (void)animateTextWithDuration:(CGFloat)duration letterRate:(CGFloat)rate
{
    if (self.animationTimer != nil)
    {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    
    [super setText:@""];
    
    self.animationStartTime = CACurrentMediaTime();
    self.currentAnimationDuration = duration;
    self.currentAnimationRate = rate;
    
    [self scheduleTextUpdateTimer];
    [self updateTextAnimationWithElapsedtime:0.0];
}

- (void)stopAnimating
{
    if (self.animationTimer != nil)
    {
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    
    [super setText:self.originalText];
}

- (void)scheduleTextUpdateTimer
{
    CGFloat timeInterval = 1.0 / self.currentAnimationRate;
    NSTimer *timer = [NSTimer timerWithTimeInterval:timeInterval
                                             target:self
                                           selector:@selector(updateTextForTimer:)
                                           userInfo:nil
                                            repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.animationTimer = timer;
}

- (void)updateTextForTimer:(NSTimer *)timer
{
    CFTimeInterval currentTime = CACurrentMediaTime();
    CFTimeInterval elapsed = currentTime - self.animationStartTime;
    
    [self updateTextAnimationWithElapsedtime:elapsed];
}

- (void)updateTextAnimationWithElapsedtime:(CFTimeInterval)elapsed
{
    CGFloat duration = self.currentAnimationDuration;
    
    NSString *originalText = self.originalText;
    NSString *newText = nil;
    
    if (elapsed > duration)
    {
        newText = self.originalText;
        
        [self.animationTimer invalidate];
        self.animationTimer = nil;
    }
    else
    {
        CGFloat interval = duration / originalText.length;
        NSInteger currentIndex = elapsed / interval;
        
        newText = [self interpolatedTextForIndex:currentIndex inString:originalText];
    }
    
    [super setText:newText];
}

- (NSString *)interpolatedTextForIndex:(NSInteger)characterIndex inString:(NSString *)text
{
    NSString *newText = nil;
    
    unichar currentChar = [text characterAtIndex:characterIndex];
    
    NSString *prefix = @"";
    NSString *suffix = [self suffixForCharacter:currentChar];
    if (characterIndex > 0)
    {
        prefix = [text substringToIndex:MIN(characterIndex, text.length)];
    }

    newText = [NSString stringWithFormat:@"%@%@", prefix, suffix];
    
    return newText;
}

- (NSString *)suffixForCharacter:(unichar)character
{
    NSString *lowerChars = @"abcdefghijklmnopqrstuvwxyz";
    NSString *upperChars = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSString *numberChars = @"01234567890";
    NSString *otherChars = @",./\\;[]<>?:|{}1234567890";
    
    static NSCharacterSet *lowerCharset = nil;
    static NSCharacterSet *upperCharset = nil;
    static NSCharacterSet *numberCharset = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        lowerCharset = [NSCharacterSet characterSetWithCharactersInString:lowerChars];
        upperCharset = [NSCharacterSet characterSetWithCharactersInString:upperChars];
        numberCharset = [NSCharacterSet characterSetWithCharactersInString:numberChars];
    });
    
    if (character == ' ')
    {
        return @" ";
    }

    NSString *chars = otherChars;
    
    if ([lowerCharset characterIsMember:character])
    {
        chars = lowerChars;
    }
    else if ([upperCharset characterIsMember:character])
    {
        chars = upperChars;
    }
    else if ([numberCharset characterIsMember:character])
    {
        chars = numberChars;
    }
    
    NSInteger idx = arc4random() % chars.length;
    return [chars substringWithRange:NSMakeRange(idx, 1)];
}

@end
