//
//  ZZStoreManager.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/31.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 储存类，键值持久化。内部采用CoreData持久化。线程安全的。
 */
@interface ZZStoreManager : NSObject
- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
- (void)trimByCapatity:(NSInteger )capatity;
- (void)removeCacheforKey:(NSString *)key;
- (void)removeAllObjects;

@end
