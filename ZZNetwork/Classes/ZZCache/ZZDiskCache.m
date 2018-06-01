//
//  ZZDiskCache.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZDiskCache.h"
#import "ZZStoreManager.h"

@interface ZZDiskCache ()
@property (strong , nonatomic) ZZStoreManager *storeManager;
@end

@implementation ZZDiskCache

- (NSObject *)objectCacheForKey:(NSString *)key{
    return [self.storeManager objectCacheForKey:key];
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    [self.storeManager setCache:value forKey:key];
}

- (ZZStoreManager *)storeManager{
    if (!_storeManager) {
        _storeManager = [ZZStoreManager new];
    }
    return _storeManager;
}
@end
