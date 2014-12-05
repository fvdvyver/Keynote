//
//  MCObserver.m
//
//  Created by Rayman Rosevear on 2013/03/19.
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import "MCObserver.h"

#import <objc/message.h>

typedef NS_ENUM(NSInteger, MCObserverBlockArgumentsKind) {
	MCObserverBlockArgumentsNone,
    MCObserverBlockArgumentsOldAndNew,
    MCObserverBlockArgumentsChangeDictionary
};

static NSUInteger SelectorArgumentCount(SEL selector);

@implementation MCObserver

// *****************************************************************************************************
#pragma mark - Object Life Cycle
// *****************************************************************************************************

- (instancetype) initForObject:(id) object
					  keyPath:(NSString*) keyPath
					  options:(NSKeyValueObservingOptions) options
						block:(dispatch_block_t) block
		   blockArgumentsKind:(MCObserverBlockArgumentsKind) blockArgumentsKind
{
    if(self = [super init])
	{
        if(object == nil || keyPath == nil || block == nil)
		{
            [NSException raise:NSInternalInconsistencyException format:@"Observation must have a valid object (%@), keyPath (%@) and block(%@)", object, keyPath, block];
            self = nil;
        }
		else
		{
            _observedObject = object;
            _keyPath = [keyPath copy];
            _block = [block copy];
			
            [_observedObject addObserver:self
                              forKeyPath:_keyPath
                                 options:options
                                 context:(void *)blockArgumentsKind];
        }
    }
    return self;
}

- (void) dealloc
{
    if(_observedObject != nil)
	{
        [self stopObserving];
    }
}

// *****************************************************************************************************
#pragma mark Block-based observer construction.
// *****************************************************************************************************

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
							 block:(MCObserverBlock) block
{
    return [[self alloc] initForObject:object
                               keyPath:keyPath
                               options:0
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:MCObserverBlockArgumentsNone];
}

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
					oldAndNewBlock:(MCObserverBlockWithOldAndNew) block
{
    return [[self alloc] initForObject:object
                               keyPath:keyPath
                               options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:MCObserverBlockArgumentsOldAndNew];
}

+ (instancetype) observerForObject:(id) object
                keyPath:(NSString*) keyPath
                options:(NSKeyValueObservingOptions) options
            changeBlock:(MCObserverBlockWithChangeDictionary) block
{
    return [[self alloc] initForObject:object
                               keyPath:keyPath
                               options:options
                                 block:(dispatch_block_t)block
                    blockArgumentsKind:MCObserverBlockArgumentsChangeDictionary];
}

// *****************************************************************************************************
#pragma mark Target-action based observer construction.
// *****************************************************************************************************

static NSUInteger SelectorArgumentCount(SEL selector)
{
    NSUInteger argumentCount = 0;
    
    const char *selectorStringCursor = sel_getName(selector);
    char ch;
    while((ch = *selectorStringCursor))
	{
        if(ch == ':')
		{
            ++argumentCount;
        }
        ++selectorStringCursor;
    }
    
    return argumentCount;
}

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
						   options:(NSKeyValueObservingOptions) options
							target:(id) target
							action:(SEL) action
{
    id ret = nil;
    
    __weak id wTarget = target;
    __weak id wObject = object;
	
    dispatch_block_t block = nil;
    MCObserverBlockArgumentsKind blockArgumentsKind;
	
    // Was doing this with an NSMethodSignature by calling
    // [target methodForSelector:action], but that will fail if the method
    // isn't defined on the target yet, beating ObjC's dynamism a bit.
    // This looks a little hairier, but it won't fail (and is probably a lot
    // more efficient anyway).
    NSUInteger actionArgumentCount = SelectorArgumentCount(action);
    
    switch(actionArgumentCount)
	{
        case 0:
		{
            block = [^{
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, action);
                }
            } copy];
            blockArgumentsKind = MCObserverBlockArgumentsNone;
        }
            break;
        case 1:
		{
            block = [^{
                id msgTarget = wTarget;
                if(msgTarget)
				{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                    [msgTarget performSelector:action withObject:wObject];
#pragma clang diagnostic pop
                }
            } copy];
            blockArgumentsKind = MCObserverBlockArgumentsNone;
        }
            break;
        case 2:
		{
            NSString *myKeyPath = [keyPath copy];
            block = [^{
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, action, wObject, myKeyPath);
                }
            } copy];
            blockArgumentsKind = MCObserverBlockArgumentsNone;
        }
            break;
        case 3:
		{
            NSString *myKeyPath = [keyPath copy];
            block = [(dispatch_block_t)(^(NSDictionary *change) {
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, action, wObject, myKeyPath, change);
                }
            }) copy];
            blockArgumentsKind = MCObserverBlockArgumentsChangeDictionary;
        }
            break;
        case 4:
		{
            NSString *myKeyPath = [keyPath copy];
            options |=  NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
            block = [(dispatch_block_t)(^(id oldValue, id newValue) {
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, action, wObject, myKeyPath, oldValue, newValue);
                }
            }) copy];
            blockArgumentsKind = MCObserverBlockArgumentsOldAndNew;
        }
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Incorrect number of arguments (%ld) in action for %s (should be 0 - 4)", (long)actionArgumentCount, __func__];
    }
    
    if(block)
	{
        ret = [[self alloc] initForObject:object
                                  keyPath:keyPath
                                  options:options
                                    block:block
                       blockArgumentsKind:blockArgumentsKind];
    }
    
    return ret;
}

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
							target:(id) target
							action:(SEL) action
{
    return [self observerForObject:object keyPath:keyPath options:0 target:target action:action];
}

// *****************************************************************************************************
#pragma mark Value-only target-action observers.
// *****************************************************************************************************

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
						   options:(NSKeyValueObservingOptions) options
							target:(id) target
					   valueAction:(SEL) valueAction
{
    id ret = nil;
    
    __weak id wTarget = target;
	
    MCObserverBlockWithChangeDictionary block = nil;
    
    NSUInteger actionArgumentCount = SelectorArgumentCount(valueAction);
    
    switch(actionArgumentCount)
	{
        case 1:
		{
            options |= NSKeyValueObservingOptionNew;
            block = [^(NSDictionary *change) {
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, valueAction, change[NSKeyValueChangeNewKey]);
                }
            } copy];
        }
            break;
        case 2:
		{
            options |= NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
            block = [^(NSDictionary *change) {
                id msgTarget = wTarget;
                if(msgTarget)
				{
                    objc_msgSend(msgTarget, valueAction, change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
                }
            } copy];
        }
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Incorrect number of arguments (%ld) in action for %s (should be 1 - 2)", (long)actionArgumentCount, __func__];
    }
    
    if(block)
	{
        ret = [[self alloc] initForObject:object
                                  keyPath:keyPath
                                  options:options
                                    block:(dispatch_block_t)block
                       blockArgumentsKind:MCObserverBlockArgumentsChangeDictionary];
    }
    
    return ret;
}

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
							target:(id) target
					   valueAction:(SEL) valueAction
{
    return [self observerForObject:object keyPath:keyPath options:0 target:target valueAction:valueAction];
}

// *****************************************************************************************************
#pragma mark - Observation
// *****************************************************************************************************

- (void) stopObserving
{
    [_observedObject removeObserver:self forKeyPath:_keyPath];
    _block = nil;
    _keyPath = nil;
    _observedObject = nil;
}

- (void) observeValueForKeyPath:(NSString*) keyPath
                      ofObject:(id) object
                        change:(NSDictionary*) change
                       context:(void*) context
{
    switch((MCObserverBlockArgumentsKind)context)
	{
        case MCObserverBlockArgumentsNone:
		{
            ((MCObserverBlock)_block)();
            break;
		}
        case MCObserverBlockArgumentsOldAndNew:
		{
            ((MCObserverBlockWithOldAndNew)_block)(change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
            break;
		}
        case MCObserverBlockArgumentsChangeDictionary:
		{
            ((MCObserverBlockWithChangeDictionary)_block)(change);
            break;
		}
        default:
            [NSException raise:NSInternalInconsistencyException format:@"%s called on %@ with unrecognised context (%p)", __func__, self, context];
    }
}

@end
