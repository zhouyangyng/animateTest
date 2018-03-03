//
//  DataBaseManager.m
//  test
//
//  Created by mac1 on 2018/3/1.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "DataBaseManager.h"

static DataBaseManager *_instance;

@interface DataBaseManager()<NSCopying>

@property (nonatomic, strong) FMDatabaseQueue *queue;

@end

@implementation DataBaseManager

///单利
+(instancetype)sharedManager {
    
    static dispatch_once_t onceToken1;
    dispatch_once(&onceToken1, ^{
        
        if(nil == _instance) {
            
            _instance = [[DataBaseManager alloc]init];
        }
    });
    return _instance;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}

-(void)createTableWithSQL:(NSString *)sql finishedBlock:(void (^)(BOOL))finishedBlock {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"创建表成功");
        }else {
            NSLog(@"创建表失败");
        }
        
        finishedBlock(result);
    }];
}


-(void)deleteTableWithSQL:(NSString *)sql {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        BOOL result = [db executeUpdate:sql];
        if (result) {
            NSLog(@"删除表成功");
        }else {
            NSLog(@"删除表失败");
        }
    }];
}

-(void)addPerson:(Person *)person {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        NSNumber *maxID = @(0);
        
        FMResultSet *res = [db executeQuery:@"SELECT * FROM person"];
        
        //获取最大id
        while ([res next]) {
            if (maxID.integerValue < [res stringForColumn:@"person_id"].integerValue) {
                maxID = @([res stringForColumn:@"person_id"].integerValue);
            }
        }
        maxID = @(maxID.integerValue + 1);
        
        //插入数据
        [db executeUpdate:@"INSERT INTO person(person_id, person_name, person_age, person_number) VALUES (?,?,?,?)", maxID, person.name, person.age, person.number];
    }];
}

-(void)deletePerson:(Person *)person {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        [db executeUpdate:@"DELETE FROM person WHERE person_id = ?", person.ID];
    }];
}

-(void)addCar:(Car *)car toPerson:(Person *)person {
    
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        //person是否有car，来添加 car_id
        NSNumber *maxID = @(0);
        FMResultSet *res = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM car where own_id = %@", person.ID]];
        
        while ([res next]) {
            if (maxID.integerValue <= [res stringForColumn:@"car_id"].integerValue) {
                maxID = @([res stringForColumn:@"car_id"].integerValue + 1);
            }
        }
        //插入car数据
        [db executeUpdate:@"INSERT INTO car(own_id, car_id, car_brand, car_price) VALUES (?,?,?,?)", person.ID, maxID, car.brand, car.price];
    }];
}

-(void)deleteCar:(Car *)car fromPerson:(Person *)person {
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        [db executeUpdate:@"DELETE FROM car WHERE own_id = ? AND car_id = ?", person.ID, car.car_id];
    }];
}

-(NSArray *)getAllPerson {
    
    NSMutableArray *mArr = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *res =[db executeQuery:@"SELECT * FROM person"];
        
        while ([res next]) {
            
            Person *person = [[Person alloc]init];
            person.ID = [res stringForColumn:@"person_id"];
            person.name = [res stringForColumn:@"person_name"];
            person.age = [res stringForColumn:@"person_age"];
            person.number = [res stringForColumn:@"person_number"];
            
            [mArr addObject:person];
        }
    }];
    
    return mArr.copy;
}

-(NSArray *)getAllCarsFromPerson:(Person *)person {
    
    NSMutableArray *mArr = [NSMutableArray array];
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        FMResultSet *res = [db executeQuery:@"SELECT * FROM car WHERE own_id = ?", person.ID];
        while ([res next]) {
            Car *car = [[Car alloc]init];
            car.own_id = person.ID;
            car.car_id = [res stringForColumn:@"car_id"];
            car.brand = [res stringForColumn:@"car_brand"];
            car.price = [res stringForColumn:@"car_price"];
            
            [mArr addObject:car];
        }
    }];
    return mArr.copy;
}

- (void)deleteAllCarsFromPerson:(Person *)person {
    
    //删除，person下的所有car,own_id等于 person.ID
    [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
       
        [db executeUpdate:@"DELETE FROM car WHERE own_id = ?", person.ID];
    }];
}


///懒加载 dataBaseQueue
- (FMDatabaseQueue *)queue {
    if (nil == _queue) {
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
        NSLog(@"%@", documentPath);
        NSString *dataBasePath = [documentPath stringByAppendingPathComponent:@"test.sqlite"];
        _queue = [[FMDatabaseQueue alloc]initWithPath:dataBasePath];
    }
    return _queue;
}

@end



