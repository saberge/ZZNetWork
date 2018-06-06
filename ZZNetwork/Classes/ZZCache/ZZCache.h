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
 必须使用shareCache 初始化。
 memoryCache 内存缓存。
 diskCache 磁盘缓存。
 */

@interface ZZCache : NSObject

#pragma mark ---cache
@property (strong ,readwrite, nonatomic) NSObject<ZZCacheProtocol> *memoryCache;
@property (strong ,readwrite, nonatomic) NSObject<ZZCacheProtocol> *diskCache;
/* 缓存条目的个数容量，LRU移除。 default is NSIntegerMax */
@property (assign , nonatomic) NSInteger capacity;

#pragma mark --- manager
- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
@end
