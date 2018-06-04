//
//  ZZProtocol.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/28.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZReponse.h"

@protocol AFMultipartFormData;
typedef void(^MultipartBlock)(id <AFMultipartFormData> formData);

typedef enum : NSUInteger {
    ZZHTTPMethodGet,
    ZZHTTPMethodPost,
} ZZHTTPMethod;


@protocol ZZProtocol <NSObject>
@property (strong ,readonly , nonatomic) NSDictionary *parameters;
@property (strong ,readonly , nonatomic) NSDictionary *headers;
@property (copy   ,readonly , nonatomic) NSString     *path;

/*
 identifier 用于cache 协议的标识
 */
@property (strong ,readonly , nonatomic) NSString      *identifier;

/*
 default ZZHTTPMethodPost
 custom by rewrite get method in your API class
 */
@property (assign ,readonly , nonatomic) ZZHTTPMethod httpMethod;

@property (copy   ,nonatomic) MultipartBlock multipartBlock;
/*
 responseModel 解析返回数据的类
 */
@property (assign ,readonly , nonatomic) Class <ZZReponse> responseModelClass;
@end
