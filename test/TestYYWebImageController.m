//
//  TestYYWebImageController.m
//  test
//
//  Created by mac1 on 2018/2/26.
//  Copyright © 2018年 mac1. All rights reserved.
//

#import "TestYYWebImageController.h"
#import <YYWebImage.h>

@interface TestYYWebImageController ()

@property (nonatomic, strong) NSArray *urlArray;

@end

@implementation TestYYWebImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    
    cell.textLabel.text = @"1111";
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 160, 110)];
    
    [cell.contentView addSubview:imgView];
    
    [imgView yy_setImageWithURL:[NSURL URLWithString:self.urlArray[indexPath.row]] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionSetImageWithFadeAnimation];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

- (NSArray *)urlArray {
    if (nil == _urlArray) {
        _urlArray = @[@"http://www.buaya.net/images/11936448290906577242.jpg", @"https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=768659932,4145837721&fm=173&s=6221B14453ECB54F58CF578B0300E08C&w=218&h=146&img.JPEG", @"http://attach.bbs.miui.com/forum/201504/05/094406wb74eokgpu7fuxnz.jpg", @"http://pic1.win4000.com/wallpaper/b/573c2ceb512c3.jpg", @"http://i1.hdslb.com/bfs/archive/9169b3a9d969be697b9bbbe5de7aa3cfc6ab4d3f.jpg"];
    }
    return _urlArray;
}

@end
