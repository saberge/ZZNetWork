//
//  WeatherInfoWarpper.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "WeatherInfoWarpper.h"
#import <YYModel.h>

@implementation WeatherInfoWarpper
+ (instancetype)zz_modelWithDictionary:(NSDictionary *)dictionary{
    return [self yy_modelWithDictionary:dictionary];
}
@end
