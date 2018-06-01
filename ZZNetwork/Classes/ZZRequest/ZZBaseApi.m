//
//  ZZBaseApi.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZBaseApi.h"

@implementation ZZBaseApi

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
    return [NSString stringWithFormat:@"%@:%@:%@",NSStringFromClass(self.class), [self.parameters.allKeys componentsJoinedByString:@"-"],[self.parameters.allValues componentsJoinedByString:@"-"]];
}

- (Class<ZZReponse>)responseModelClass{
    return nil;
}

@end
