//
//  ZZCache.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZCache.h"

@interface ZZCache ()

@end;

@implementation ZZCache
+ (instancetype)shareCache{
    static dispatch_once_t once;
    static ZZCache *cache;
    dispatch_once(&once, ^ {
        cache = [ZZCache new];
    });
    return cache;
}

- (NSObject *)objectCacheForKey:(NSString *)key{
    NSObject *cache = [self.memoryCache objectCacheForKey:key];
    if (cache) return cache;
    return [self.diskCache objectCacheForKey:key];
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    [self.memoryCache  setCache:value forKey:key];
    [self.diskCache  setCache:value forKey:key];
}

#pragma mark --- getters
- (NSObject<ZZCacheProtocol> *)memoryCache{
    if (!_memoryCache) {
        _memoryCache = [ZZMemoryCache new];
    }
    return _memoryCache;
}

- (NSObject<ZZCacheProtocol> *)diskCache{
    if (!_diskCache) {
        _diskCache = [ZZDiskCache new];
    }
    return _diskCache;
}
@end
