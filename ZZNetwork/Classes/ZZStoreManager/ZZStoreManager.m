//
//  ZZStoreManager.m
//  ZZNetwork
//
//  Created by 郑来贤 on 2018/5/31.
//  Copyright © 2018年 郑来贤. All rights reserved.
//

#import "ZZStoreManager.h"
#import <CoreData/CoreData.h>
#import "ZZKeyValueEntity+CoreDataProperties.h"
#import "ZZKeyValueEntity+CoreDataClass.h"

#define kEntityName @"ZZKeyValueEntity"
#define kModelName  @"ZZKeyValueDB"
#define kDBName     @"ZZKeyValueDB"

@interface ZZStoreManager ()
@property (strong , nonatomic) NSManagedObjectModel *keyValueModel;
@property (strong , nonatomic) NSManagedObjectContext *objectContext;
@property (strong , nonatomic) NSPersistentStoreCoordinator *coordinator;
@end

@implementation ZZStoreManager

- (NSObject *)objectCacheForKey:(NSString *)key{
    ZZKeyValueEntity *entity = [self searchWithKey:key];
    return entity.value;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    ZZKeyValueEntity *entity = [self searchWithKey:key];
    if (entity) {
        entity.value = value;
    }
    else{
        entity = [NSEntityDescription
                                      insertNewObjectForEntityForName:kEntityName
                                      inManagedObjectContext:self.objectContext];
        entity.value = value;
        entity.key = key;
    }
    
    if ([self.objectContext hasChanges]) {
        NSError *error = nil;
        [self.objectContext save:&error];
        NSAssert(error == nil, error.localizedFailureReason);
    }
}

- (ZZKeyValueEntity *)searchWithKey:(NSString *)key{
    // 设置过滤条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key = %@",key];
    NSFetchRequest *request = [ZZKeyValueEntity fetchRequest];
    request.predicate = predicate;
    // 执行获取操作，获取所有Student托管对象
    NSError *error = nil;
    NSArray<ZZKeyValueEntity *> *keyValues = [self.objectContext executeFetchRequest:request error:&error];
    if (keyValues.count == 1) return keyValues.firstObject;
    if (error) NSAssert(NO, error.localizedDescription);
    if (keyValues.count >1) NSAssert(NO, @"查询多个值");
    return nil;

}

#pragma mark --- getters ---
- (NSManagedObjectModel *)keyValueModel{
    if (!_keyValueModel) {
        _keyValueModel = [self objectModelWithName:kModelName];
    }
    return _keyValueModel;
}

- (NSPersistentStoreCoordinator *)coordinator{
    if (!_coordinator) {
        _coordinator = [self coordinatorWithModel:self.keyValueModel];
    }
    return _coordinator;
}

- (NSManagedObjectContext *)objectContext{
    if (!_objectContext) {
        _objectContext = [self contextWithType:NSMainQueueConcurrencyType coordinator:self.coordinator];
    }
    return _objectContext;
}

#pragma mark -- core data ---
- (NSManagedObjectContext *)contextWithType:(NSManagedObjectContextConcurrencyType)type coordinator:(NSPersistentStoreCoordinator *)coor{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc]initWithConcurrencyType:type];
    context.persistentStoreCoordinator = coor;
    return context;
}

- (NSManagedObjectModel *)objectModelWithName:(NSString *)modelName{
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
}

- (NSPersistentStoreCoordinator *)coordinatorWithModel:(NSManagedObjectModel *)objectModel{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:objectModel];
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", kDBName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    return coordinator;
}
@end
