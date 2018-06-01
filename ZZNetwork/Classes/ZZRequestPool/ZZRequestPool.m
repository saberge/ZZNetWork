//
//  ZZPool.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZRequestPool.h"
#import "ZZCategory.h"

@interface ZZRequestPool ()
{
    NSMutableDictionary *cacheDic;
}
@end

@implementation ZZRequestPool

+(instancetype)sharePool{
    static dispatch_once_t once;
    static ZZRequestPool *pool;
    dispatch_once(&once, ^ {
        pool = [ZZRequestPool new];
    });
    return pool;
}

- (BOOL)containReqeust:(ZZRequest *)request{
    if (!cacheDic) return NO;
    
    NSString *key = request.curProto.identifier.MD5;
    NSParameterAssert(key.length);
    return [[cacheDic allKeys] containsObject:key];
}

- (void)addRequest:(ZZRequest *)request{
    static dispatch_once_t once;
    dispatch_once(&once, ^ {
        cacheDic = [NSMutableDictionary new];
    });
    
    NSString *key = request.curProto.identifier.MD5;
    NSParameterAssert(key.length);
    [cacheDic setValue:request forKey:key];
}

- (void)removeRequest:(ZZRequest *)request{
    NSString *key = request.curProto.identifier.MD5;
     NSParameterAssert(key.length);
    [cacheDic removeObjectForKey:key];
}

@end
