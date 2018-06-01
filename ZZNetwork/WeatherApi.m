//
//  WeatherApi.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "WeatherApi.h"
#import "WeatherInfo.h"
#import "WeatherInfoWarpper.h"

@implementation WeatherApi

- (NSString *)path{
    return @"http://www.weather.com.cn/data/sk/101190408.html";
}

- (ZZHTTPMethod)httpMethod{
    return ZZHTTPMethodGet;
}

- (NSDictionary *)parameters{
    return @{};
}

- (NSDictionary *)headers{
    return @{};
}

- (NSString *)identifier{
    return NSStringFromClass(self.class);
}

- (Class<ZZReponse>)responseModelClass{
    return [WeatherInfoWarpper class];
}
@end
