//
//  WeatherInfo.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "WeatherInfo.h"
#import "ZZRequestPool.h"
#import <YYModel.h>

@implementation WeatherInfo
+ (nullable instancetype)zz_modelWithDictionary:(NSDictionary *)dictionary{
    return [self yy_modelWithDictionary:dictionary];
}
@end
