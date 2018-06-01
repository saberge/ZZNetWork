//
//  NSDate+ZZ.m
//  ZZCategory
//
//  Created by 郑来贤 on 2018/5/26.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "NSDate+ZZ.h"
#import <mach/mach_time.h>
#import <QuartzCore/QuartzCore.h>
#import <sys/sysctl.h>

@implementation NSDate (ZZ)

#pragma mark --- time ---

+(CFTimeInterval)currentMachAbsoluteTime{
    return mach_absolute_time();
}

+ (CFTimeInterval)currentMediaTime{
    return CACurrentMediaTime();
}

+ (CFTimeInterval)systemUptime{
    return [[NSProcessInfo processInfo] systemUptime];
}

+ (CFTimeInterval)lastRestartTime{
#define MIB_SIZE 2
    int mib[MIB_SIZE];
    size_t size;
    struct timeval  boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    if (sysctl(mib, MIB_SIZE, &boottime, &size, NULL, 0) != -1)
    {
        return boottime.tv_sec;
    }
    return 0;
}

+ (CFTimeInterval)absoluteTimeGetCurrent{
    return CFAbsoluteTimeGetCurrent();
}

+ (CFTimeInterval)getTimeOfDay{
    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);
    return now.tv_sec;
}
@end
