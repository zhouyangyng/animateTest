//
//  WaveLayerController.m
//  test
//
//  Created by mac1 on 2017/11/9.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "WaveLayerController.h"
#import "FirstWaveView.h"
#import "SecondWaveView.h"

@interface WaveLayerController ()

@property (nonatomic, strong) FirstWaveView *firstView;

@property (nonatomic, strong) SecondWaveView *secondView;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WaveLayerController
{
    
    CGFloat offsetX;
    CGFloat waveSpeed;
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWilDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.firstView = [[FirstWaveView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 300)];
    self.firstView.alpha = 0.6;
    [self.view addSubview:self.firstView];
    
    self.secondView = [[SecondWaveView alloc]initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 300)];
    self.secondView.alpha = 0.6;
    [self.view addSubview:self.secondView];
    
    //定时  振荡
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(addShakeAnimation) userInfo:nil repeats:YES];
}

///振荡
- (void)addShakeAnimation {
    
    [UIView animateWithDuration:1.5 animations:^{
        
        self.firstView.transform = CGAffineTransformMakeTranslation(0, 20);
        self.secondView.transform = CGAffineTransformMakeTranslation(0, 20);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:1.5 animations:^{
            
            self.firstView.transform = CGAffineTransformMakeTranslation(0, 0);
            self.secondView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:nil];
    }];
}

-(void)dealloc {
    
    NSLog(@"%s", __func__);
}

@end


