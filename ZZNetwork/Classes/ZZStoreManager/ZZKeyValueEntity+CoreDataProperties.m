//
//  ZZKeyValueEntity+CoreDataProperties.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/6/1.
//  Copyright © 2018年 郑来贤. All rights reserved.
//
//

#import "ZZKeyValueEntity+CoreDataProperties.h"

@implementation ZZKeyValueEntity (CoreDataProperties)

+ (NSFetchRequest<ZZKeyValueEntity *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"ZZKeyValueEntity"];
}

@dynamic key;
@dynamic value;

@end
