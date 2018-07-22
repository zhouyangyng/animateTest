//
//  ViewController.m
//  test
//
//  Created by mac1 on 2017/8/21.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "WKViewController.h"
#import "AniViewController.h"
#import "PetalViewController.h"
#import "WaveLayerController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) CALayer *petalLayer;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *nameArray;

@property (nonatomic, strong) NSArray *vcArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    self.nameArray = @[@"花瓣掉落",@"立体旋转", @"波浪", @"UIWebView", @"WKWebView", @"UIAlertController", @"测试YYWebImage", @"测试FMDB", @"测试RestKit"];
    self.vcArray = @[@"PetalViewController", @"AniViewController", @"WaveLayerController", @"WebViewController", @"WKViewController", @"MyAlertController", @"TestYYWebImageController", @"FMDBTestController", @"RESTKitTestController"];
    
    NSLog(@"111");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.nameArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    cell.textLabel.text = self.nameArray[indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *vcString = self.vcArray[indexPath.row];
    
    Class cls = NSClassFromString(vcString);
    
    [self.navigationController pushViewController:[[cls alloc]init] animated:YES];
}

// UIWebView
- (IBAction)testClick:(id)sender {
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)testWKTest:(id)sender {
    
    WKViewController *vc = [[WKViewController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)imageAnimation:(id)sender {
    
    AniViewController *aniVC = [[AniViewController alloc]init];
    
    [self.navigationController pushViewController:aniVC animated:YES];
}

- (IBAction)waveLayerClick:(id)sender {
    
    WaveLayerController *vc = [[WaveLayerController alloc]init];
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


-(UITableView *)tableView {
    
    if (nil == _tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end




