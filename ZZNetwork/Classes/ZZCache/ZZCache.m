//
//  ZZCache.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZCache.h"
#import <UIKit/UIKit.h>

@interface ZZCache ()

@end;

@implementation ZZCache
- (instancetype)init
{
    self = [super init];
    if (self) {
        _memoryCache = [ZZMemoryCache new];
        _diskCache = [ZZDiskCache new];
        self.capacity = NSIntegerMax; // default
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(momeryWarning) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (NSObject *)objectCacheForKey:(NSString *)key{
    NSObject *cache = [self.memoryCache objectCacheForKey:key];
    if (cache) return cache;
    cache = [self.diskCache objectCacheForKey:key];
    // add to cache
    if (cache) [self.memoryCache setCache:cache forKey:key];
    return cache;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    if (!key)  return;
    if (value) {
        [self.memoryCache  setCache:value forKey:key];
        [self.diskCache  setCache:value forKey:key];
    }
    else{
        [self.memoryCache removeCacheforKey:key];
        [self.diskCache removeCacheforKey:key];
    }
}

- (void)setCapacity:(NSInteger)capacity{
    if (_capacity != capacity) {
        _memoryCache.capacity =  capacity;
        _diskCache.capacity = capacity;
        _capacity = capacity;
    }
}

- (void)momeryWarning{
    [self.memoryCache removeAllObjects];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
