//
//  ZZMemoryCache.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZMemoryCache.h"
#import <pthread.h>
#import <ZZCategory/NSDate+ZZ.h>

#pragma mark --- linkNode
@interface ZZLinkNode:NSObject

@property (weak   , nonatomic) ZZLinkNode *prev;
@property (weak   , nonatomic) ZZLinkNode *next;
@property (strong , nonatomic) id key;
@property (strong , nonatomic) id value;
@property (assign , nonatomic) CFTimeInterval time;

@end

@implementation ZZLinkNode @end

#pragma mark --- linkMap
@interface ZZLinkMap:NSObject
@property (strong  , nonatomic) ZZLinkNode *head; //MRU
@property (strong  , nonatomic) ZZLinkNode *tail; //LRU
@property (strong  , nonatomic) NSMutableDictionary *dic; //store node

#pragma mark -- manage
- (void)insertNode:(ZZLinkNode *)node;
- (void)removeNode:(ZZLinkNode *)node;
- (void)bringNodeToHead:(ZZLinkNode *)node;
- (void)removeAllNodes;

@end

@implementation ZZLinkMap

- (void)insertNode:(ZZLinkNode *)node{
    if (_head) {
         node.next = _head;
        _head.prev = node;
        _head = node;
    }
    else{
        _head = _tail = node;
    }
    
    [_dic setValue:node forKey:node.key];
}

- (void)removeNode:(ZZLinkNode *)node{
    if (node.next) node.next.prev = node.prev;
    if (node.prev) node.prev.next = node.next;
    if (_head == node) _head = node.next;
    if (_tail == node) _tail = node.prev;
    
    [_dic removeObjectForKey:node.key];
}

- (void)removeAllNodes{
    _head = _tail = nil;
    [_dic removeAllObjects];
}

- (void)bringNodeToHead:(ZZLinkNode *)node{
    if (node == _head ) return;
    
    if (node == _tail) {
        _tail = node.prev;
        _tail.next = nil;
    }
    else{
        node.next.prev = node.prev;
        node.prev.next = node.next;
    }
    
    node.next = _head;
    node.prev = nil;
    _head.prev = node;
    _head = node;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary new];
    }
    return self;
}

@end

@interface ZZMemoryCache ()
@property (strong , nonatomic) ZZLinkMap *linkMap;
@property (strong , nonatomic) dispatch_queue_t queue;
@end

@implementation ZZMemoryCache
- (instancetype)init
{
    self = [super init];
    if (self) {
        _linkMap = [ZZLinkMap new];
        _queue = dispatch_queue_create("com.zznetwork.cache.memory", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (NSObject *)objectCacheForKey:(NSString *)key{
    if (!key) return nil;
    ZZLinkNode *node = node = [self.linkMap.dic valueForKey:key];
    return node.value;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    if (!key) return;
    dispatch_sync(_queue, ^{
        ZZLinkNode *node = [self.linkMap.dic valueForKey:key];
        if (!value) {
            if (node) [self.linkMap removeNode:node];
        }
        else{
            CFTimeInterval curTime = [NSDate currentMediaTime];
            if (node) {
                node.time = curTime;
                [_linkMap bringNodeToHead:node];
            }
            else{
                node = [ZZLinkNode new];
                node.time = curTime;
                node.value = value;
                node.key = key;
                [_linkMap insertNode:node];
                
                if (_capacity != NSIntegerMax) [self removeNodeByCapatity:_linkMap.dic.allKeys.count];
            }
        }
    });
}

- (void)removeNodeByCapatity:(NSInteger )capatity{
    if (capatity >_capacity) {
        ZZLinkNode *node = _linkMap.tail;
        [_linkMap removeNode:node];
    }
}

- (void)removeCacheforKey:(NSString *)key;{
    [self setValue:nil forKey:key];
}

- (void)removeAllObjects{
    dispatch_sync(_queue, ^{
        [_linkMap removeAllNodes];
    });
}
@end
