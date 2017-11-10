//
//  MyView.m
//  test
//
//  Created by mac1 on 2017/8/21.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "MyView.h"

@implementation MyView


- (void) drawRect:(CGRect)rect {
    
    /*
    // 1. 随便画一个路径出来.
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(10, 10)];
    [path addLineToPoint: CGPointMake(160, 40)];
    [path addLineToPoint: CGPointMake( 40,  80)];
    [path addLineToPoint: CGPointMake(40, 40)];
    path.lineWidth = 3;
    
    // 2. 为这条路径制作一个反转路径
    UIBezierPath *reversingPath = [path bezierPathByReversingPath];
    reversingPath.lineWidth = 3;
    
    // 3. 为了避免两条路径混淆在一起, 我们为第一条路径做一个位移
    CGAffineTransform transform = CGAffineTransformMakeTranslation(200, 0);
    [path applyTransform: transform];
    
    // 4. 两条路径分别添加一条直接到 self.center
    [path addLineToPoint: CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)];
    [reversingPath addLineToPoint: CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)];
    
    // 5. 设置颜色, 并绘制路径
    [[UIColor redColor] set];
    [path stroke];
    
    [[UIColor greenColor] set];
    [reversingPath stroke];
     
     */
    
   
    /*
    // 1. 先创建三条路径, 有对比更有助于理解
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(80, 60)];
    [path addLineToPoint: CGPointMake(self.frame.size.width - 40, 40)];
    path.lineWidth = 2;
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint: CGPointMake(80, 120)];
    [path1 addLineToPoint: CGPointMake(self.frame.size.width - 40, 80)];
    path1.lineWidth = 2;
    
    
//    UIBezierPath *path2 = [UIBezierPath bezierPath];
//    [path2 moveToPoint: CGPointMake(80, 180)];
//    [path2 addLineToPoint: CGPointMake(self.frame.size.width - 40, 120)];
//    path2.lineWidth = 2;
    
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200, 300) radius:90 startAngle:0 endAngle:M_PI clockwise:YES];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(200, 300)];
    [path2 addArcWithCenter:CGPointMake(200, 300) radius:100 startAngle:0 endAngle:M_PI*0.9 clockwise:YES];
    path2.lineWidth = 3;
    [path2 closePath];
    
    CGFloat lineDahConfig[] = {8.0, 4.0};
    [path setLineDash:lineDahConfig count:2 phase:0];
    
    CGFloat lineDahConfig1[] = {16.0, 7.0};
    [path1 setLineDash:lineDahConfig1 count:2 phase:0];
    
    
    CGFloat lineDahConfig2[] = {8.0, 4.0};
    [path2 setLineDash:lineDahConfig2 count:2 phase:12];
    
    
    [[UIColor orangeColor] setStroke];
    
    [path stroke];
    [path1 stroke];
    [path2 stroke];
    
    */
    
    UIColor *color = [UIColor redColor];
    [color set];//设置线条颜色
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 5.0;
    aPath.lineCapStyle = kCGLineCapRound;//线条拐角
    aPath.lineJoinStyle = kCGLineCapRound;//终点处理
    [aPath moveToPoint:CGPointMake(20, 200)];
    [aPath addQuadCurveToPoint:CGPointMake(240, 200) controlPoint:CGPointMake(110, 0)];
    [aPath stroke];

    
}

@end





