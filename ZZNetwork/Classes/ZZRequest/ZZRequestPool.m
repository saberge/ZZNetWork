//
//  ZZPool.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZRequestPool.h"
#import "ZZRequest.h"
#import "ZZProtocol.h"
#import <ZZCategory/NSString+ZZ.h>

@interface ZZRequestPool ()
@property (strong , nonatomic) NSMutableDictionary *cacheDic;
@end

@implementation ZZRequestPool
@synthesize cacheDic = cacheDic;

+(instancetype)sharePool{
    static dispatch_once_t once;
    static ZZRequestPool *pool;
    dispatch_once(&once, ^ {
        pool = [ZZRequestPool new];
    });
    return pool;
}

- (BOOL)containReqeust:(ZZRequest *)request{
    if (!self.cacheDic) return NO;
    
    NSString *key = request.curProto.identifier.MD5;
    NSParameterAssert(key.length);
    return [[self.cacheDic allKeys] containsObject:key];
}

- (void)addRequest:(ZZRequest *)request{
    NSString *key = request.curProto.identifier.MD5;
    NSParameterAssert(key.length);
    [self.cacheDic setValue:request forKey:key];
}

- (void)removeRequest:(ZZRequest *)request{
    NSString *key = request.curProto.identifier.MD5;
     NSParameterAssert(key.length);
    [self.cacheDic removeObjectForKey:key];
}

#pragma mark --- getters
- (NSMutableDictionary *)cacheDic{
    if (!cacheDic) {
        cacheDic = [NSMutableDictionary new];
    }
    return cacheDic;
}

@end
