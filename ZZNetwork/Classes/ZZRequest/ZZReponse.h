//
//  ZZReponse.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/30.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ZZReponse <NSObject>
+ (nullable instancetype)zz_modelWithDictionary:(NSDictionary *)dictionary;
@end
