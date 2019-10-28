//
//  ZZRequestHander.m
//  AFNetworking
//
//  Created by laixian on 2019/10/20.
//

#import "ZZRequestHander.h"

@implementation ZZRequestHander

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken ;
    static ZZRequestHander *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init] ;
    }) ;
    return instance ;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [ZZRequestHander shareInstance];
}

- (id)copyWithZone:(struct _NSZone *)zone
{
    return [ZZRequestHander shareInstance];
}
@end
