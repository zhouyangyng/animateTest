//
//  MyAlertController.m
//  test
//
//  Created by mac1 on 2017/12/11.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "MyAlertController.h"
#import <objc/runtime.h>
#import <Masonry.h>

@interface MyAlertController ()

@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, strong) NSPort *emptyPort;

@end

@implementation MyAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
    
    //先走主线程，再开3个子线程，3个顺序随机
    dispatch_queue_t my_queue1 = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 3; i++) {
        dispatch_async(my_queue1, ^{
            NSLog(@"task1-%d-%@", i, [NSThread currentThread]);
        });
    }
    
    NSLog(@"task1-%@", [NSThread currentThread]);
    
    
    
    
//    [self memoryTest];
    
    
}

- (void)synchronizedTest {
    
    NSObject *obj = [[NSObject alloc]init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        @synchronized(obj){
            
            NSLog(@"线程同步操作 111  开始");
            sleep(2);
            NSLog(@"线程同步操作 111  结束");
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        sleep(1);
        //        NSLog(@"线程22");
        @synchronized(obj) {
            NSLog(@"线程同步操作 222 ");
        }
    });
}

- (void)memoryTest {
    for (int i = 0; i < 100000; ++i) {
        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [thread start];
//        [self performSelector:@selector(stopThread) onThread:thread withObject:nil waitUntilDone:YES];
    }
}

- (void)stopThread {
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSThread *thread = [NSThread currentThread];
    [thread cancel];
}

- (void)run {
    @autoreleasepool {
        NSLog(@"current thread = %@", [NSThread currentThread]);
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        if (!self.emptyPort) {
            self.emptyPort = [NSMachPort port];
        }
        [runLoop addPort:self.emptyPort forMode:NSDefaultRunLoopMode];
        [runLoop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    }
}

//点击按钮 弹窗
- (void)buttonClick:(UIButton *)sender{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"这是一个弹窗O__O " message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"忽略" style:UIAlertActionStyleDefault handler:nil];
    
    [sureAction setValue:[UIColor redColor] forKey:@"titleTextColor"];
    [cancelAction setValue:[[UIImage imageNamed:@"star"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forKey:@"image"];


    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc]initWithString:@"有颜色的title有颜色的title有颜色的title有颜色的title有颜色的title" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blueColor]}];

    [alert setValue:titleStr forKey:@"attributedTitle"];

    NSMutableAttributedString *messageStr = [[NSMutableAttributedString alloc]initWithString:@"有颜色的message" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor purpleColor]}];

    [alert setValue:messageStr forKey:@"attributedMessage"];
    
    [alert setValue:@1 forKey:@"_titleMaximumLineCount"];
    [alert setValue:@(NSLineBreakByTruncatingMiddle) forKey:@"_titleLineBreakMode"];
    
    
    /*
    NSLineBreakByWordWrapping = 0,      // Wrap at word boundaries, default
    NSLineBreakByCharWrapping,          // Wrap at character boundaries
    NSLineBreakByClipping,              // Simply clip
    NSLineBreakByTruncatingHead,        // Truncate at head of line: "...wxyz"
    NSLineBreakByTruncatingTail,        // Truncate at tail of line: "abcd..."
    NSLineBreakByTruncatingMiddle       // Truncate middle of line:  "ab...yz"
    */
    
    unsigned int count;
    
    Ivar * properties = class_copyIvarList([UIAlertController class], &count);
    
    for (unsigned int i = 0; i < count; i++) {
        
        Ivar property = properties[i];
        
        const char *propertyName = ivar_getName(property);
        
        NSLog(@"%s", propertyName);
        
    }
    
    
    [alert addAction:cancelAction];
    
    [alert addAction:sureAction];
    
    [alert addAction:ignoreAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)dealloc {
    
    NSLog(@"%s", __func__);
}

-(UIButton *)btn{
    if (nil == _btn) {
        _btn = [[UIButton alloc]init];
        [_btn setTitle:@"点我弹窗" forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor colorWithRed:0.33 green:0.53 blue:0.27 alpha:1]];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

@end




