//
//  Factory.h
//  test
//
//  Created by 周洋 on 2018/6/10.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Factory : NSObject

//标题
@property (nonatomic, copy) NSString *title;
//区
@property (nonatomic, copy) NSString *area;
//城市
@property (nonatomic, copy) NSString *city;
//地址
@property (nonatomic, copy) NSString *address;
//联系电话
@property (nonatomic, copy) NSString *phone;

@end
