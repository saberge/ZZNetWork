//
//  ZZMemoryCache.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCacheProtocol.h"

/*
 内存缓存类，
 setCache是线程安全的。在后台线程同步执行。
 objectCacheForKey 立即返回当时的值，可能不准。
 */
@interface ZZMemoryCache : NSObject<ZZCacheProtocol>
- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
- (void)removeCacheforKey:(NSString *)key;
/* 缓存条目的个数容量，LRU移除。*/
@property (assign , nonatomic) NSInteger capacity;

- (void)removeAllObjects;
@end
