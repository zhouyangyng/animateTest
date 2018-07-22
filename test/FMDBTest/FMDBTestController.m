//
//  FMDBTestController.m
//  test
//
//  Created by mac1 on 2018/3/1.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "FMDBTestController.h"
#import "DataBaseManager.h"
#import "PersonGarageController.h"

#import "test-Swift.h"

@interface FMDBTestController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;   //所有的数据

@end

@implementation FMDBTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置界面相关
    [self setup];
    
    [self initialDataBase];
    
    TestSwiftController *vc = [[TestSwiftController alloc]init];
    
    [vc testPrint];
    
    [vc testType];
}

- (void)initialDataBase {
    
    BOOL res1 = [[NSUserDefaults standardUserDefaults] boolForKey:@"personRes"];
    
    BOOL res2 = [[NSUserDefaults standardUserDefaults] boolForKey:@"carRes"];
    
    if (res1 && res2) {
        //表已经存在，取出数据
        
        self.dataArray = [[DataBaseManager sharedManager] getAllPerson];
        [self.tableView reloadData];
        return;
    }
    
    //创建person、car表
    NSString *personSql = @"create table 'person' ('id' integer primary key autoincrement not null, 'person_id' varchar(255), 'person_name' varchar(255), 'person_age' varchar(255), 'person_number' varchar(255))";
    NSString *carSql = @"CREATE TABLE 'car' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'own_id' VARCHAR(255), 'car_id' VARCHAR(255), 'car_brand' VARCHAR(255), 'car_price' VARCHAR(255))";
    
    
    [[DataBaseManager sharedManager] createTableWithSQL:personSql finishedBlock:^(BOOL result) {
        
        [[NSUserDefaults standardUserDefaults] setBool:result forKey:@"personRes"];
    }];
    [[DataBaseManager sharedManager] createTableWithSQL:carSql finishedBlock:^(BOOL result) {
        [[NSUserDefaults standardUserDefaults] setBool:result forKey:@"carRes"];
    }];
}


- (void)setup {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addPersonToTable)];
    [self.view addSubview:self.tableView];
}

//点击 添加一个person
- (void)addPersonToTable {
    
    NSInteger nameRandom = arc4random_uniform(10000);
    
    NSInteger ageRadom = arc4random_uniform(100) + 1;
    
    //名字 name
    NSString *name = [NSString stringWithFormat:@"person_%ld号", nameRandom];
    
    Person *person = [[Person alloc]init];
    person.name = name;
    person.age = [NSString stringWithFormat:@"%ld", ageRadom];
    
    //添加到数据库
    [[DataBaseManager sharedManager] addPerson:person];
    
    //添加后，重新获取 person数据
    self.dataArray = [[DataBaseManager sharedManager] getAllPerson];
    
    //刷新tableView
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"personCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"personCell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //person数据
    Person *person = self.dataArray[indexPath.row];
    
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"age: %@", person.age];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonGarageController *vc = [[PersonGarageController alloc]init];
    Person *per = self.dataArray[indexPath.row];
    vc.person = per;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView {
    
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArray {
    
    if (nil == _dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

@end



