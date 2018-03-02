//
//  DataBaseManager.h
//  test
//
//  Created by mac1 on 2018/3/1.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import <FMDatabaseQueue.h>
#import <FMDatabaseQueue.h>
#import "Person.h"
#import "Car.h"

@interface DataBaseManager : NSObject


/**
 * 返回单利对象
 */
+ (instancetype)sharedManager;


/**
 * 创建 表
 */
- (void)createTableWithSQL:(NSString *)sql;

/**
 * 删除 表
 */
- (void)deleteTableWithSQL:(NSString *)sql;

/**
 * 添加 person
 */
- (void)addPerson:(Person *)person;

/**
 * 删除 person
 */
- (void)deletePerson:(Person *)person;

/**
 * 获取所有的 person
 */
- (NSArray *)getAllPerson;

/**
 * 添加car给person
 */
- (void)addCar:(Car *)car toPerson:(Person *)person;

/**
 * 删除person的car
 */
- (void)deleteCar:(Car *)car fromPerson:(Person *)person;

/**
 * 获取person的所有car
 */
- (NSArray *)getAllCarsFromPerson:(Person *)person;

/**
 * 删除person的所有car
 */
- (void)deleteAllCarsFromPerson:(Person *)person;

@end



