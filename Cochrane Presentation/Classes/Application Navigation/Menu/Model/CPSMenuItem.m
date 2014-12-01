//
//  CPSMenuItem.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/11/10.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSMenuItem.h"

@interface CPSMenuItem ()

// Cached copy of the delegate method
@property (nonatomic, assign) SEL delegateMethod;

- (BOOL)invokeDelegateSelector:(SEL)selector withTarget:(id)target;

@end

@implementation CPSMenuItem

- (instancetype)initWithIdentifier:(NSString *)identifier title:(NSString *)title icon:(UIImage *)icon
{
    if (self = [super init])
    {
        _identifier = identifier;
        _title = title;
        _iconImage = icon;
    }
    return self;
}

- (BOOL)invokeAction:(id<CPSMenuItemDelegate>)delegate
{
    BOOL returnValue = NO;
    
    if (delegate != nil)
    {
        returnValue = [self invokeDelegateSelector:self.delegateMethod withTarget:delegate];
    }
    return returnValue;
}

- (BOOL)invokeDelegateSelector:(SEL)selector withTarget:(id)target
{
    __unsafe_unretained id uself = self;
    NSMethodSignature *signature = [(id)target methodSignatureForSelector:selector];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    
    [invocation setSelector:self.delegateMethod];
    [invocation setTarget:target];
    [invocation setArgument:&uself atIndex:2];
    
    [invocation invoke];
    
    NSUInteger returnLength = [signature methodReturnLength];
    char valueBuffer[returnLength];
    [invocation getReturnValue:&valueBuffer];
    
    return valueBuffer[0];
}

- (SEL)delegateMethod
{
    if (_delegateMethod == NULL)
    {
        NSString *className = NSStringFromClass([self class]);
        if ([className isEqualToString:@"CPSMenuItem"])
        {
            _delegateMethod = @selector(menuItemSelected:);
        }
        else
        {
            // Dynamically generate the method name based on the name of the class
            // Remove "MenuItem" from the end of the class name
            NSString *suffix = @"MenuItem";
            if ([className hasSuffix:suffix])
            {
                className = [className substringToIndex:className.length - suffix.length];
            }
            
            // Remove the namespace prefix
            NSCharacterSet *nonUpperCharset = [[NSCharacterSet uppercaseLetterCharacterSet] invertedSet];
            NSInteger namespaceLength = [className rangeOfCharacterFromSet:nonUpperCharset].location;
            if (namespaceLength > 0 && namespaceLength != NSNotFound)
            {
                className = [className substringFromIndex:namespaceLength - 1];
            }
            
            // add "MenuItemSelected:" prefix
            className = [NSString stringWithFormat:@"%@%@Selected:", className, suffix];
            // make the first character lowercase
            className = [NSString stringWithFormat:@"%@%@", [[className substringWithRange:NSMakeRange(0, 1)] lowercaseString], [className substringFromIndex:1]];
            
            _delegateMethod = NSSelectorFromString(className);
        }
    }
    return _delegateMethod;
}

@end
