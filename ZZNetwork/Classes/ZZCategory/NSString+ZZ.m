//
//  NSString+ZZ.m
//  ZZCategory
//
//  Created by 郑来贤 on 2018/5/26.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "NSString+ZZ.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ZZ)

- (NSString *)MD5{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
