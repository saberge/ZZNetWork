//
//  ZZBaseApi.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZProtocol.h"

/*
 every request base instance.
 custom for your request api :
         1. conform ZZProtocol
         2. inherit ZZBaseApi
 */
@interface ZZBaseApi : NSObject<ZZProtocol>
@property (strong ,readonly , nonatomic) NSDictionary *parameters;
@property (strong ,readonly , nonatomic) NSDictionary *headers;
@property (copy   ,readonly , nonatomic) NSString     *path;
@property (assign ,readonly , nonatomic) ZZHTTPMethod  httpMethod; //ZZHTTPMethodGet for default
@property (copy   ,nonatomic) MultipartBlock multipartBlock;
@property (assign ,readonly , nonatomic) Class <ZZReponse> responseModelClass;

@end
