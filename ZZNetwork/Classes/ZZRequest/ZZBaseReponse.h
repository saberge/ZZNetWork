//
//  ZZBaseReponse.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZReponse.h"

/*
 every request response model. default use YYModel: https://github.com/ibireme/YYModel
 custom for your request response :
 1. conform ZZReponse
 2. inherit ZZBaseReponse
 3. overwrite zz_modelWithDictionary: you can use other model transfer
 */
@interface ZZBaseReponse : NSObject<ZZReponse>
+ (nullable instancetype)zz_modelWithDictionary:(NSDictionary *)dictionary;
@end
