//
//  ZZRequest.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/28.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZProtocol.h"

/*
    发起网络请求的类。
 *  TODU:
 */

@class ZZRequest;
@protocol ZZAsyRequestDelegate <NSObject>
@optional
- (void)didSendRequest:(ZZRequest *)request;
- (void)didReciveData:(id)data request:(ZZRequest *)request;
- (void)didFailure:(NSError *)error request:(ZZRequest *)request;
@end

@interface ZZRequest : NSObject

@property (strong ,readonly , nonatomic) NSObject <ZZProtocol> *curProto;
@property (assign ,readonly , nonatomic) BOOL fromCache;

+ (instancetype)requestWithProto:(NSObject<ZZProtocol> *)proto
                        delegate:(id<ZZAsyRequestDelegate >) delegate;

+ (instancetype)requestWithPath:(NSString *)path
                           para:(NSDictionary *)paras
                         method:(ZZHTTPMethod )mehod
                     modelClass:(id <ZZReponse>)modelClass
                       delegate:(id <ZZAsyRequestDelegate>)delegate;
- (void)start;
- (void)cancle;
@end
