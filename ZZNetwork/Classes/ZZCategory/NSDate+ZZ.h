//
//  NSDate+ZZ.h
//  ZZCategory
//
//  Created by 郑来贤 on 2018/5/26.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 *  GMT 英国伦敦的格林尼治天文台所在地（Greenwich Mean Time）
 *  UTC 微观粒子原子的物理属性，建立了原子钟，以这种原子钟来衡量时间的变化，原子钟50亿年才会误差1秒，这种精读已经远胜于GMT  了。这个原子钟所反映的时间，也就是我们现在所使用的UTC（Coordinated Universal Time ）标准时间.
 *  NSDate 用的是UTC标准
 */
@interface NSDate (ZZ)

#pragma mark --- time ---
/*
   获取的是cup的运行tickCount.CACurrentMediaTime(void)函数返回的其实是这个tickCount转化为时间结果
    受系统重启，关机影响，不受系统时间更改影响
    UTC标准
 */
+ (CFTimeInterval )currentMachAbsoluteTime;

/*
    currentMachAbsoluteTime返回结果的时间度量，受系统重启，关机影响.内部调用CACurrentMediaTime()
    受系统重启，关机影响，不受系统时间更改影响
    UTC标准
 */
+ (CFTimeInterval )currentMediaTime;

/*
    和CurrentMediaTime 类似，只是内部调用的是[[NSProcessInfo processInfo] systemUptime]
    受系统重启，关机影响，不受系统时间更改影响
    UTC标准
 */
+ (CFTimeInterval )systemUptime;

/*
 *  记录上次设备重启的时间，通过sysctl
    受系统重启，关机影响，受系统时间更改影响.Since1970,记录的是重启时刻手机的系统时间
    UTC标准
 */
+ (CFTimeInterval )lastRestartTime;

/*
    和NSDate类似
    受系统时间更改影响,SinceReferenceDate
    GMT标准
 */
+ (CFTimeInterval )absoluteTimeGetCurrent;

/*
     返回当前时间
     受系统时间更改影响.Since1970
     UTC标准
 */
+ (CFTimeInterval )getTimeOfDay;


@end
