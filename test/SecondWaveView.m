//
//  SecondWaveView.m
//  test
//
//  Created by mac1 on 2017/11/10.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "SecondWaveView.h"


@interface SecondWaveView()

@property (nonatomic, strong) CAShapeLayer *waveLayer;

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation SecondWaveView

{
    
    CGFloat width;
    CGFloat offsetX;
    CGFloat waveSpeed;
    CGFloat currentY;
    CGFloat waveA;
    CGFloat waveW;
}


-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.masksToBounds = YES;
        
        [self setupWaves];
    }
    
    return self;
}

- (void)setupWaves {
    
    width = self.bounds.size.width;
    waveSpeed = 1/35.0;
    offsetX = 0.0f;
    currentY = self.bounds.size.height * 0.5;
    
    _waveLayer = [CAShapeLayer layer];
    _waveLayer.frame = CGRectMake(0, 0, width, 300);
    _waveLayer.fillColor = [UIColor colorWithRed:104/255.0 green:176/255.0 blue:255/255.0 alpha:1].CGColor;
    [self.layer addSublayer:_waveLayer];
    
    waveA = 9;
    waveW = 0.028f;
    
    //开始 CADisplayLink
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(addWaveLayer)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    
    
}

- (void)addWaveLayer {
    
    offsetX += waveSpeed;
    
    [self setWaveLayerPath];
}

- (void)setWaveLayerPath {
    
    CGFloat y = currentY;
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGPathMoveToPoint(path, nil, 0, y);
    
    for (CGFloat i = 0.0f; i < width; i++) {
        
        y = waveA * sin(waveW * i + offsetX) + currentY;
        CGPathAddLineToPoint(path, nil, i, y);
    }
    CGPathAddLineToPoint(path, nil,width , 0);
    CGPathAddLineToPoint(path, nil, 0, 0);
    
    CGPathCloseSubpath(path);
    
    _waveLayer.path = path;
    
    CGPathRelease(path);
}

@end


