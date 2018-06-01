//
//  ZZKeyValueEntity+CoreDataProperties.h
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/6/1.
//  Copyright © 2018年 郑来贤. All rights reserved.
//
//

#import "ZZKeyValueEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZZKeyValueEntity (CoreDataProperties)

+ (NSFetchRequest<ZZKeyValueEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *key;
@property (nullable, nonatomic, retain) NSObject *value;

@end

NS_ASSUME_NONNULL_END
