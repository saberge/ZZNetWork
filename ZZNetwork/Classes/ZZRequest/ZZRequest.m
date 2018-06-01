//
//  ZZRequest.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/28.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZRequest.h"
#import "AFNetworking.h"
#import "ZZRequestPool.h"
#import "ZZReponse.h"
#import "ZZCache.h"
#import "NSString+ZZ.h"

@interface ZZRequest ()
@property (strong , nonatomic) NSObject<ZZProtocol> *curProto;
@property (strong , nonatomic) NSURLSessionDataTask *curSessionDataTask;
@property (weak   , nonatomic) id<ZZAsyRequestDelegate > delegate;
@property (assign , readwrite , nonatomic) BOOL fromCache;

@end

@implementation ZZRequest

+ (instancetype)requestWithProto:(NSObject<ZZProtocol> *)proto delegate:(id<ZZAsyRequestDelegate>)delegate{
    NSParameterAssert(proto);
    ZZRequest *request = [ZZRequest new];
    request.curProto = proto;
    request.delegate = delegate;
    return request;
}

- (void)start{
    NSParameterAssert(_curProto);
    self.fromCache = NO;
    if (!_curProto) return;
    
    NSObject *cache = [[ZZCache shareCache] objectCacheForKey:_curProto.identifier.MD5];
    if (cache) {
         self.fromCache = YES;
        [self requestSuccess:nil response:cache];
    }
    self.fromCache = NO;
    if ([[ZZRequestPool sharePool] containReqeust:self]) return;
    [[ZZRequestPool sharePool] addRequest:self];
    
    _curSessionDataTask = [self sendAFRequestProto:_curProto];
    
    if ([_delegate respondsToSelector:@selector(didSendRequest:)]) {
        [_delegate didSendRequest:self];
    }
}

- (void)cancle{
    _delegate = nil;
    [_curSessionDataTask cancel];
    _curSessionDataTask = nil;
}

- (void)dealloc{
    [self cancle];
}

- (NSURLSessionDataTask *)sendAFRequestProto:(NSObject<ZZProtocol> *)proto{
    NSURLSessionDataTask *sessionDataTask = nil;
    AFHTTPSessionManager *manager = [self shareRequestManger];
    NSDictionary *parameters = proto.parameters;
    NSString *url = proto.path;
    ZZHTTPMethod method = proto.httpMethod;
    switch (method) {
        case ZZHTTPMethodGet:
            {
                if (proto.multipartBlock) {
                    NSAssert(NO, @"must use post when multipartBlock");
                }
                else{
                    sessionDataTask = [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        [self requestSuccess:task response:responseObject];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        [self requestFailure:task error:error];
                    }];
                }
            }
            break;
        case ZZHTTPMethodPost:
        {
            if (proto.multipartBlock) {
                sessionDataTask = [manager POST:url parameters:parameters constructingBodyWithBlock:_curProto.multipartBlock progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self requestSuccess:task response:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self requestFailure:task error:error];
                }];
            }
            else{
                sessionDataTask = [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [self requestSuccess:task response:responseObject];
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [self requestFailure:task error:error];
                }];
            }
        }
            break;
        default:
        {
            NSAssert(NO, @"use correct HttpMethod");
        }
            break;
    }
    return sessionDataTask;
}

- (void)requestSuccess:(NSURLSessionDataTask *)task response:(id  _Nullable )responseObject{
    id resonse = responseObject;
    
    if (_curProto.responseModelClass) {
        resonse = [_curProto.responseModelClass zz_modelWithDictionary:responseObject];
    }
    if ([_delegate respondsToSelector:@selector(didReciveData:request:)]) {
        [_delegate didReciveData:resonse request:self];
    }
    if (!_fromCache) {
        [[ZZRequestPool sharePool] removeRequest:self];
        [[ZZCache shareCache] setCache:responseObject forKey:_curProto.identifier.MD5];
    }
}

- (void)requestFailure:(NSURLSessionDataTask *)task error:(NSError  *_Nullable )error{
    if ([_delegate respondsToSelector:@selector(didFailure:request:)]) {
        [_delegate didFailure:error request:self];
    }
    if (!_fromCache) [[ZZRequestPool sharePool] removeRequest:self];
}

- (AFHTTPSessionManager *)shareRequestManger{
    static dispatch_once_t once;
    static AFHTTPSessionManager *manager;
    dispatch_once(&once, ^ {
        // defalut
        //TODU: can config by user
        manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *jsonResponseSerializer = [AFJSONResponseSerializer serializer];
        [jsonResponseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html",nil]];
        manager.responseSerializer = jsonResponseSerializer;
    });
    return manager;
}


@end
