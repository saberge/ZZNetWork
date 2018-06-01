//
//  WeatherInfo.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/29.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZReponse.h"

@interface WeatherInfo : NSObject<ZZReponse>

@property (strong , nonatomic) NSString *Radar;
@property (strong , nonatomic) NSString *SD;
@property (strong , nonatomic) NSString *WD;
@property (strong , nonatomic) NSString *WS;
@property (strong , nonatomic) NSString *WSE;
@property (strong , nonatomic) NSString *city;
@property (strong , nonatomic) NSString *cityid;
@property (strong , nonatomic) NSString *isRadar;
@property (strong , nonatomic) NSString *njd;
@property (strong , nonatomic) NSString *qy;
@property (strong , nonatomic) NSString *rain;
@property (strong , nonatomic) NSString *temp;
@property (strong , nonatomic) NSString *time;


+ (nullable instancetype)zz_modelWithDictionary:(NSDictionary *)dictionary;

@end
