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
#import "NSDate+ZZ.h"

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
    ZZKeyValueEntity *entity = [self searchWithKey:key].firstObject;
    return entity.value;
}

- (void)setCache:(NSObject *)value forKey:(NSString *)key{
    NSAssert(value != nil, @"");
    ZZKeyValueEntity *entity = [self searchWithKey:key].firstObject;
    if (entity) {
        entity.value = value;
        entity.time = @([NSDate absoluteTimeGetCurrent]);
    }
    else{
        entity = [NSEntityDescription
                                      insertNewObjectForEntityForName:kEntityName
                                      inManagedObjectContext:self.objectContext];
        entity.value = value;
        entity.key = key;
        entity.time = @([NSDate absoluteTimeGetCurrent]);
    }
    
    [self.objectContext performBlock:^{
        if ([self.objectContext hasChanges]) {
             NSError *error = nil;
            [self.objectContext save:&error];
            NSAssert(error == nil, error.localizedFailureReason);
        }
    }];
}

- (void)trimByCapatity:(NSInteger)capatity{
    NSArray<ZZKeyValueEntity *> *keyValues = [self searchWithKey:nil];
    for (NSInteger  i = keyValues.count-1;i >= 0;i--) {
        if (i >= capatity-1) {
            ZZKeyValueEntity *entity = keyValues[i];
            [self.objectContext performBlockAndWait:^{
                [self.objectContext deleteObject:entity];
            }];
        }else{
            break;
        }
    }
    
    [self.objectContext performBlock:^{
        if ([self.objectContext hasChanges]) {
            NSError *error = nil;
            [self.objectContext save:&error];
            NSAssert(error == nil, error.localizedFailureReason);
        }
    }];
}

- (void)removeAllObjects{
    NSArray<ZZKeyValueEntity *> *keyValues = [self searchWithKey:nil];
    for (NSInteger  i = keyValues.count-1;i >= 0;i--) {
            ZZKeyValueEntity *entity = keyValues[i];
            [self.objectContext performBlockAndWait:^{
                [self.objectContext deleteObject:entity];
            }];
    }
    [self.objectContext performBlock:^{
        if ([self.objectContext hasChanges]) {
            NSError *error = nil;
            [self.objectContext save:&error];
            NSAssert(error == nil, error.localizedFailureReason);
        }
    }];
}

- (void)removeCacheforKey:(NSString *)key{
    
    ZZKeyValueEntity *entity = [self searchWithKey:key].firstObject;
    [self.objectContext performBlockAndWait:^{
        [self.objectContext deleteObject:entity];
    }];
    
    [self.objectContext performBlock:^{
        if ([self.objectContext hasChanges]) {
            NSError *error = nil;
            [self.objectContext save:&error];
            NSAssert(error == nil, error.localizedFailureReason);
        }
    }];
}

- (NSArray<ZZKeyValueEntity *> *)searchWithKey:(NSString *)key{
    NSFetchRequest *request = [ZZKeyValueEntity fetchRequest];
    // 设置过滤条件
    if (key) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"key = %@",key];
        request.predicate = predicate;
    }
    
    NSSortDescriptor * sort = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:NO];
    request.sortDescriptors = @[sort];
    
    __block NSError *error = nil;
    __block NSArray<ZZKeyValueEntity *> *keyValues;
    [self.objectContext performBlockAndWait:^{
        keyValues = [self.objectContext executeFetchRequest:request error:&error];
    }];
    
    NSAssert(error == nil, error.localizedDescription);
    return keyValues;
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
        _objectContext = [self contextWithType:NSPrivateQueueConcurrencyType coordinator:self.coordinator];
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
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:NSStringFromClass(self.class) ofType:@"bundle"];
    NSBundle *nibBundle = [NSBundle bundleWithPath:bundlePath];
    NSURL *modelPath = [nibBundle URLForResource:modelName withExtension:@"momd"];
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
