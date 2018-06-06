//
//  ZZDiskCache.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZCacheProtocol.h"

/*
 磁盘缓存类，采用coredata 持久化缓存。 见ZZStoreManager
 setCache是线程安全的。在后台线程同步执行。
 objectCacheForKey 立即返回当时的值，可能不准。
 */
@interface ZZDiskCache : NSObject<ZZCacheProtocol>
@property (assign , nonatomic) NSInteger capacity;

- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
- (void)removeAllObjects;
@end
