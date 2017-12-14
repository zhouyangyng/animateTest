//
//  PetalViewController.m
//  test
//
//  Created by 周洋 on 2017/11/11.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "PetalViewController.h"
#import "MyView.h"

@interface PetalViewController ()

@property (nonatomic, strong) CALayer *petalLayer;

@end

@implementation PetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyView *v = [[MyView alloc]initWithFrame:self.view.bounds];
    
    v.backgroundColor = [UIColor whiteColor];
    
    self.view.backgroundColor = [UIColor blackColor];
    //
    //    [self.view addSubview:v];
    //
//    [self.view.layer addSublayer:self.petalLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self animationGroup:[[touches anyObject] locationInView:self.view]];
    
}


/**
 掉落的动画
 
 */
- (CAKeyframeAnimation *)move:(CGPoint)endPoint{
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    UIBezierPath *path = [UIBezierPath bezierPath];
    //设置起始点
    [path moveToPoint:self.petalLayer.position];
    //画曲线的方法addCurveToPoint:终点 controlPoint1:<#(CGPoint)#> controlPoint2:<#(CGPoint)#>
    [path addCurveToPoint:endPoint controlPoint1:CGPointMake(50, 150) controlPoint2:CGPointMake(300, 300)];
    keyFrame.path = path.CGPath;
    //节奏动画不是匀速 kCAAnimationPaced
    keyFrame.calculationMode = kCAAnimationCubicPaced;
    
    return keyFrame;
}


/**
 旋转
 
 */
- (CABasicAnimation *)rotation {
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    ani.fromValue = @(M_PI_4);
    
    //不同的 toValue
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"ss";
    NSString *sec = [formatter stringFromDate:date];
    NSString *lastStr = [sec substringFromIndex:1];
    
    ani.toValue = @(2 * M_PI + lastStr.integerValue/5.0 * M_PI  );
    
    ani.repeatCount = MAXFLOAT;
    
    return ani;
}


/**
 变大
 
 */
- (CABasicAnimation *)moveToBig {
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"bounds"];
    
    ani.fromValue = [NSValue valueWithCGRect:self.petalLayer.bounds];
    
    ani.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.petalLayer.bounds.size.width * 1.3, self.petalLayer.bounds.size.height * 1.3)];
    
    return ani;
}


/**
 动画数组
 
 */
- (void)animationGroup:(CGPoint)endPoint {
    
    //创建layer
    CALayer *petalLayer = [CALayer layer];
    
    petalLayer.position = CGPointMake(self.view.center.x, 50);
    
    UIImage *img = [UIImage imageNamed:@"petal"];
    
    petalLayer.bounds =  CGRectMake(0, 0, img.size.width, img.size.height);
    
    petalLayer.contents = (id)img.CGImage;
    
    [self.view.layer addSublayer:petalLayer];
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    group.animations = @[[self move:endPoint], [self rotation], [self moveToBig]];
    
    group.duration = 3;
    
    group.removedOnCompletion = NO;
    
    group.fillMode = kCAFillModeBoth;
    
    //添加到 花瓣layer
    [petalLayer addAnimation:group forKey:@""];
}

- (CALayer *)petalLayer {
    
    if (nil == _petalLayer) {
        
        _petalLayer = [CALayer layer];
        
        _petalLayer.position = CGPointMake(self.view.center.x, 50);
        
        UIImage *img = [UIImage imageNamed:@"petal"];
        
        _petalLayer.bounds =  CGRectMake(0, 0, img.size.width, img.size.height);
        
        _petalLayer.contents = (id)img.CGImage;
    }
    return _petalLayer;
}


@end


