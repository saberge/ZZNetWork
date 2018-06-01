//
//  UIApplication+ZZ.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/31.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "UIApplication+ZZ.h"

@implementation UIApplication (ZZ)

+ (NSString *)documentPathUrl{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
