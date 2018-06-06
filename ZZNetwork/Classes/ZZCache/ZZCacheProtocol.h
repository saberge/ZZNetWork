//
//  ZZCacheProtocol.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ZZCacheProtocol <NSObject>
- (NSObject *)objectCacheForKey:(NSString *)key;
- (void)setCache:(NSObject *)value forKey:(NSString *)key;
- (void)removeAllObjects;
/* 缓存条目的个数容量，LRU移除。*/
@property (assign , nonatomic) NSInteger capacity;
@end
