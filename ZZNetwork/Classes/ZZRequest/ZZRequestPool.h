//
//  ZZRequestPool.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZRequest;
/*
 当前正在网络请求的池，用于规避重复的网络请求。
 */
@interface ZZRequestPool : NSObject

+ (instancetype)sharePool;

- (BOOL)containReqeust:(ZZRequest *)request;
- (void)addRequest:(ZZRequest *)request;
- (void)removeRequest:(ZZRequest *)request;
@end
