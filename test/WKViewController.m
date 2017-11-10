//
//  WKViewController.m
//  test
//
//  Created by mac1 on 2017/8/28.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "WKViewController.h"
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>


@interface WKViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) UIButton *jsButton;

@property WKWebViewJavascriptBridge *webViewBridge;

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initWKWebView];
    
    [self.view addSubview:self.jsButton];
    
    //加载html
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"demo.html" withExtension:nil];

    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    
//    //实例化 bridge
    _webViewBridge = [WKWebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self];

    
}

- (void)initWKWebView
{
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"demo.html" ofType:nil];
    NSString *localHtml = [NSString stringWithContentsOfFile:urlStr encoding:NSUTF8StringEncoding error:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:urlStr];
    [self.webView loadHTMLString:localHtml baseURL:fileURL];
    
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)registerNativeFunctions {
    
    
}

// 注册的获取位置信息的Native 功能
- (void)registLocationFunction
{
    [self.webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        
        NSString *location = @"广东省深圳市南山区学府路XXXX号";
        // 将结果返回给js
        responseCallback(location);
    }];
}


-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        self.title = (NSString *)result;
    }];
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *url = navigationAction.request.URL;
    
    NSLog(@"%@, %@, %@", url.scheme, url.host, url.query);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(nonnull WKNavigationResponse *)navigationResponse decisionHandler:(nonnull void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    
}

//点击按钮，调用JS
- (void)buttonClick {
    
    
}

-(UIButton *)jsButton {
    
    if (nil == _jsButton) {
        
        _jsButton = [[UIButton alloc]initWithFrame:CGRectMake(160, 400, 70, 30)];
        [_jsButton setTitle:@"调用" forState:UIControlStateNormal];
        _jsButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [_jsButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_jsButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jsButton;
}

@end







