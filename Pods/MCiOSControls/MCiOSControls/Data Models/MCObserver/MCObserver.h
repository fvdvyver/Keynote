//
//  MCObserver.h
//
//  Created by Rayman Rosevear on 2013/03/19.
//  Copyright (c) 2013 Mushroom Cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *	This provides a simple, object based interface to KVO, highly based on https://github.com/th-in-gs/THObserversAndBinders
 */

@interface MCObserver : NSObject {
	
@public
	__weak id _observedObject;
    NSString *_keyPath;
    dispatch_block_t _block;
}

#pragma mark -
#pragma mark Block-based observers.

typedef void(^MCObserverBlock)(void);
typedef void(^MCObserverBlockWithOldAndNew)(id oldValue, id newValue);
typedef void(^MCObserverBlockWithChangeDictionary)(NSDictionary *change);

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
							 block:(MCObserverBlock) block;

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
					oldAndNewBlock:(MCObserverBlockWithOldAndNew) block;

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
						   options:(NSKeyValueObservingOptions) options
					   changeBlock:(MCObserverBlockWithChangeDictionary) block;

// *****************************************************************************************************
#pragma mark - Target-action based observers.
// *****************************************************************************************************

// Target-action based observers take a selector with a signature with 0-4
// arguments, and call it like this:
//
// 0 arguments: [target action];
//
// 1 argument:  [target actionForObject:object];
//
// 2 arguments: [target actionForObject:object keyPath:keyPath];
//
// 3 arguments: [target actionForObject:object keyPath:keyPath change:changeDictionary];
//     Don't expect anything in the change dictionary unless you supply some
//     NSKeyValueObservingOptions.
//
// 4 arguments: [target actionForObject:object keyPath:keyPath oldValue:oldValue newValue:newValue];
//     NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew will be
//     automatically added to your options if they're not already there and you
//     supply a 4-argument callback.
//
// The action should not return any value (i.e. should be declared to return
// void).
//
// Both the observer and the target are weakly referenced internally.

+ (instancetype) observerForObject:(id)object
						   keyPath:(NSString *)keyPath
							target:(id)target
							action:(SEL)action;

+ (instancetype) observerForObject:(id)object
						   keyPath:(NSString *)keyPath
						   options:(NSKeyValueObservingOptions)options
							target:(id)target
							action:(SEL)action;


// A second kind of target-action based observer; takes a selector with a
// signature with 1-2 arguments, and call it like this:
//
// 1 argument:  [target actionWithNewValue:newValue];
//
// 2 arguments: [target actionWithOldValue:oldValue newValue:newValue];
//
// The action should not return any value (i.e. should be declared to return
// void).
//
// Both the observer and the target are weakly referenced internally.

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
							target:(id) target
					   valueAction:(SEL) valueAction;

+ (instancetype) observerForObject:(id) object
						   keyPath:(NSString*) keyPath
						   options:(NSKeyValueObservingOptions) options
							target:(id) target
					   valueAction:(SEL) valueAction;


// *****************************************************************************************************
#pragma mark - Lifetime management
// *****************************************************************************************************

// This is a one-way street. Call it to stop the observer functioning.
// The MCObserver will do this cleanly when it deallocs, but calling it manually
// can be useful in ensuring an orderly teardown.
- (void) stopObserving;

@end
