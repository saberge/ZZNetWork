//
//  ZZCache.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZMemoryCache.h"
#import "ZZDiskCache.h"
#import "ZZCacheProtocol.h"
/*
 缓存
 */

typedef NS_OPTIONS(NSUInteger, ZZCacheType) {
    ZZCacheTypeNone                 = 0,
    ZZCacheTypeMemory               = 1 << 1,
    ZZCacheTypeDisk                 = 2 << 1,
};

@interface ZZCache : NSObject<ZZCacheProtocol>

#pragma mark ---cache
@property (strong ,readwrite, nonatomic) NSObject<ZZCacheProtocol> *memoryCache;
@property (strong ,readwrite, nonatomic) NSObject<ZZCacheProtocol> *diskCache;

#pragma mark --- init
+ (instancetype)shareCache;

#pragma mark --- manager
- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
@end
