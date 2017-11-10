//
//  WebViewController.m
//  test
//
//  Created by mac1 on 2017/8/24.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) UIButton *jsButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.jsButton];
    
    //加载html
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"demo.html" withExtension:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://m.jd.com"]]];
    
    
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    __weak typeof(self) weakSelf = self;
    //获取异常
    self.context.exceptionHandler = ^(JSContext *context, JSValue *exception){
        
        weakSelf.context.exception = exception;
        NSLog(@"%@", exception);
    };
    
    //JS 调用 OC
    self.context[@"callOC"] = ^(){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JS调用OC" message:@"OC弹窗" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil]];
        [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
    };
    
    //JS调用OC，获取参数
    self.context[@"jsCallOCWithArgument"] = ^(){
      
        //获取参数
        NSArray *argArray = [JSContext currentArguments];
        NSMutableString *mStr = [NSMutableString string];
        
        for (JSValue *value in argArray) {
            
            NSLog(@"%@", value.toString);
            [mStr appendString:value.toString];
        }
        
        //弹框
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"JS调用OC" message:mStr preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:nil]];
        [weakSelf.navigationController presentViewController:alert animated:YES completion:nil];
    };
    
    
    //调用OC，打开APP
    self.context[@"openCFZX"] = ^() {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"weixin://"]options:@{} completionHandler:nil];
        
    };
    
    //加法
    self.context[@"testAddMethod"] = ^(NSInteger a, NSInteger b) {
        
        return a + b;
    };
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    NSURL *url = request.URL;
    
    NSLog(@"%@", url.absoluteString);
    
    
    return YES;
}


//点击按钮，调用JS
- (void)buttonClick {
    
    [self.context evaluateScript:@"outputResult()"];
}

- (UIWebView *)webView {
    
    if (nil == _webView) {
        
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.delegate = self;
    }
    return _webView;
}

-(UIButton *)jsButton {
    
    if (nil == _jsButton) {
        
        _jsButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 400, 70, 30)];
        [_jsButton setTitle:@"调用" forState:UIControlStateNormal];
        _jsButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [_jsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_jsButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jsButton;
}

@end





