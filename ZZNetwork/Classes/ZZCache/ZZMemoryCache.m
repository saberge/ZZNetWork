//
//  ZZMemoryCache.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZMemoryCache.h"
#import "NSDate+ZZ.h"

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
}

- (void)removeNode:(ZZLinkNode *)node{
    if (node.next) node.next.prev = node.prev;
    if (node.prev) node.prev.next = node.next;
    if (_head == node) _head = node.next;
    if (_tail == node) _tail = node.prev;
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
@end

@implementation ZZMemoryCache

- (NSObject *)objectCacheForKey:(NSString *)key{
    ZZLinkNode *node = [self.linkMap.dic valueForKey:key];
    return node.value;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
   ZZLinkNode *node = [self.linkMap.dic valueForKey:key];
    CFTimeInterval curTime = [NSDate currentMediaTime];
    if (node) {
        node.time = curTime;
        [_linkMap bringNodeToHead:node];
    }
    else{
        node = [ZZLinkNode new];
        node.time = curTime;
        node.value = value;
        [_linkMap insertNode:node];
    }
}

#pragma mark -- getters
- (ZZLinkMap *)linkMap{
    if (!_linkMap) {
        _linkMap = [ZZLinkMap new];
    }
    return _linkMap;
}

@end
