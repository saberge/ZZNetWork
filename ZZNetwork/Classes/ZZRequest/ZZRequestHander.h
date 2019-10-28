//
//  ZZRequestHander.h
//  AFNetworking
//
//  Created by laixian on 2019/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZZRequestHander : NSObject
+ (instancetype)shareInstance;

@property (nonatomic ,copy) BOOL (^ZZRequestHanderBlock)(NSInteger code ,NSDictionary *data);

@end

NS_ASSUME_NONNULL_END
