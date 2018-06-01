//
//  WeatherApi.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZProtocol.h"

@interface WeatherApi : NSObject<ZZProtocol>
@property (strong ,readonly , nonatomic) NSDictionary *parameters;
@property (strong ,readonly , nonatomic) NSDictionary *headers;
@property (copy   ,readonly , nonatomic) NSString     *path;
@property (assign ,readonly , nonatomic) ZZHTTPMethod  httpMethod;
@property (assign ,readonly , nonatomic) Class <ZZReponse> responseModelClass;
@property (copy   ,nonatomic) MultipartBlock multipartBlock;

@end
