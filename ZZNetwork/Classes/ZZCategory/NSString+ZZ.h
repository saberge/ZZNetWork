//
//  NSString+ZZ.h
//  ZZCategory
//
//  Created by 郑来贤 on 2018/5/26.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
   NSString commonly used method.
 */
@interface NSString (ZZ)

#pragma mark ---crypto---
/*
 MD5:
 1.长度固定: 不管多长的字符串，加密之后都是一样的长度。
 2.容易计算: 字符串和文件的加密过程是相对较容易的，程序猿很容易理解并做出加密工具。
 3.细微性:   不管多大的文件，只要改变里面的某个字符，都会导致 md5 值的改变，针对这个特点，有些软件和网站提供的下载资源，其中包含了文件的 md5 码，用户下载后只需要用工具测一下下载好的文件的 md5 码，通过对比就能知道文件是否有过变动。
 4.不可逆性: MD5 加密目前来说一般是不可逆的。这也大大提高了数据的安全性。
 */
- (NSString *)MD5;

@end
