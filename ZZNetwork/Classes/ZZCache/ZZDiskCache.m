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
@property (strong , nonatomic) dispatch_queue_t queue;
@end

@implementation ZZDiskCache

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("com.zznetwork.cache.disk", DISPATCH_QUEUE_SERIAL);
        _storeManager = [ZZStoreManager new];
    }
    return self;
}

- (NSObject *)objectCacheForKey:(NSString *)key{
    NSObject *ob = [self.storeManager objectCacheForKey:key];
    return ob;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    if (value) {
        dispatch_sync(_queue, ^{
            [self.storeManager setCache:value forKey:key];
            if (_capacity != NSIntegerMax) [self.storeManager trimByCapatity:_capacity];
        });
    }else{
        [self removeCacheforKey:key];
    }
}

- (void)removeCacheforKey:(NSString *)key{
    dispatch_sync(_queue, ^{
        [self.storeManager removeCacheforKey:key];
    });
}

- (void)removeAllObjects{
    dispatch_sync(_queue, ^{
        [self.storeManager removeAllObjects];
    });
}
@end
