//
//  CPSCompatUtils.m
//  Cochrane Presentation
//
//  Created by Rayman Rosevear on 2014/12/08.
//  Copyright (c) 2014 Mushroom Cloud. All rights reserved.
//

#import "CPSCompatUtils.h"

#import <sys/utsname.h>

@implementation CPSCompatUtils

NS_INLINE NSString* cps_deviceName()
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

// Currently, this method will only disable the video playback on the iPad3,3 model or lower
+ (BOOL)InfoSpecViewShouldPlaySecurityLevelVideo
{
    BOOL shouldPlay = YES;
    NSString *deviceName = cps_deviceName();
    if ([deviceName hasPrefix:@"iPad"])
    {
        NSString *modelNumber = [deviceName stringByReplacingOccurrencesOfString:@"iPad" withString:@""];
        modelNumber = [modelNumber stringByReplacingOccurrencesOfString:@"," withString:@"."];
        
        NSString *reqModelNum = @"3.3";
        if ([modelNumber compare:reqModelNum options:NSNumericSearch] != NSOrderedDescending)
        {
            shouldPlay = NO;
        }
    }
    
    return shouldPlay;
}

@end
