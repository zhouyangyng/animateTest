//
//  PersonGarageController.m
//  test
//
//  Created by 周洋 on 2018/3/3.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "PersonGarageController.h"
#import "DataBaseManager.h"
#import "Car.h"

@interface PersonGarageController ()

@property (nonatomic, strong) NSArray *carsArray;

@end

@implementation PersonGarageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCarToPerson)];
    
    self.carsArray = [[DataBaseManager sharedManager] getAllCarsFromPerson:self.person];
}

//给person添加car
- (void)addCarToPerson {
    
    Car *car = [[Car alloc]init];
    NSArray *brandArray = @[@"奥迪", @"宝马", @"奔驰", @"保时捷", @"迈巴赫", @"马自达", @"大众", @"丰田", @"雪佛兰", @"别克", @"五菱荣光", @"沃尔沃", @"雷克萨斯", @"荣威", @"斯柯达", @"路虎", @"名爵", @"玛莎拉蒂"];
    NSInteger numRadom = arc4random_uniform(@(brandArray.count).intValue);
    car.brand = brandArray[numRadom];
    car.price = [NSString stringWithFormat:@"%.1f万", arc4random_uniform(5000)/10.0f];
    
    [[DataBaseManager sharedManager] addCar:car toPerson:self.person];
    
    self.carsArray = [[DataBaseManager sharedManager] getAllCarsFromPerson:self.person];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.carsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"carCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"carCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置car数据
    Car *car = self.carsArray[indexPath.row];
    cell.textLabel.text = car.brand;
    cell.detailTextLabel.text = car.price;
    
    return cell;
}

-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        Car *car = self.carsArray[indexPath.row];
        
        [[DataBaseManager sharedManager] deleteCar:car fromPerson:self.person];
        
        self.carsArray = [[DataBaseManager sharedManager] getAllCarsFromPerson:self.person];
        [self.tableView reloadData];
    }];
    
    return @[action];
}

-(NSArray *)carsArray {
    if (nil == _carsArray) {
        _carsArray = [NSArray array];
    }
    return _carsArray;
}

@end
