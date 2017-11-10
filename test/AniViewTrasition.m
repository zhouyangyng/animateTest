//
//  AniViewTrasition.m
//  test
//
//  Created by mac1 on 2017/11/3.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "AniViewTrasition.h"
#import "UIView+anchorPoint.h"

@interface AniViewTrasition()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation AniViewTrasition

+ (instancetype)trasitionWithType:(AniViewTrasitionType)type {
    
    return [[self alloc]initWithTrasitionType:type];
}

-(instancetype)initWithTrasitionType:(AniViewTrasitionType)type {
    
    if (self = [super init]) {
        _type = type;
    }
    return self;
}


/**
 * 动画时长
 */
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return 1;
}


/**
 * 如何执行动画
 */
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    switch (_type) {
        case AniViewTrasitionTypePush:
            
            [self startPushAnimation:transitionContext];
            break;
        case AniViewTrasitionTypePop:
            
            [self startPopAnimation:transitionContext];
            break;
            
        default:
            break;
    }
}

- (void)startPushAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    //获取vc
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //获取 containerView
    UIView *containerView = [transitionContext containerView];
    
    //或者 fromVC的截图，toVC的截图
    UIImage *fromImage = [self convertViewToImage:[UIApplication sharedApplication].keyWindow];
    
    UIImage *toImage = [self convertViewToImage:toVC.view];
    
    UIView *tempView = fromVC.view;
  
    //创建UIImageView,动画
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    imgView.image = fromImage;
    
//    [containerView addSubview:imgView];
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    
    CATransition *transition = [[CATransition alloc]init];

    transition.type     =   @"pageCurl";
    transition.subtype  =   kCATransitionFromRight;

    transition.duration = 0.7;
    
    

    self.imgView.image = toImage;

//    [self.imgView.layer addAnimation:transition forKey:@"trasition"];
    
//    开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
//        首先我们让vc2向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
//        然后让截图视图缩小一点即可
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
//        使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
//            失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
//            然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
    
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//        //转场失败后的处理
//        if ([transitionContext transitionWasCancelled]) {
//            //失败后，我们要把vc1显示出来
//            fromVC.view.hidden = NO;
//            [tempView removeFromSuperview];
//            toVC.view.hidden = NO;
//
//            //然后移除截图视图，因为下次触发present会重新截图
////            [self.imgView removeFromSuperview];
//
//
//        }
//    });
    
     
    
    /*
    
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //snapshotViewAfterScreenUpdates可以对某个视图截图，我们采用对这个截图做动画代替直接对vc1做动画，因为在手势过渡中直接使用vc1动画会和手势有冲突，    如果不需要实现手势的话，就可以不是用截图视图了，大家可以自行尝试一下
    UIView *tempView = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    tempView.frame = fromVC.view.frame;
    //因为对截图做动画，vc1就可以隐藏了
    fromVC.view.hidden = YES;
    //这里有个重要的概念containerView，如果要对视图做转场动画，视图就必须要加入containerView中才能进行，可以理解containerView管理着所有做转场动画的视图
    UIView *containerView = [transitionContext containerView];
    //将截图视图和vc2的view都加入ContainerView中
    [containerView addSubview:tempView];
    [containerView addSubview:toVC.view];
    //设置vc2的frame，因为这里vc2present出来不是全屏，且初始的时候在底部，如果不设置frame的话默认就是整个屏幕咯，这里containerView的frame就是整个屏幕
    toVC.view.frame = CGRectMake(0, containerView.bounds.size.height, containerView.bounds.size.width, 400);
    开始动画吧，使用产生弹簧效果的动画API
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:1.0 / 0.55 options:0 animations:^{
        首先我们让vc2向上移动
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -400);
        然后让截图视图缩小一点即可
        tempView.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不用手势present的话直接传YES也是可以的，但是无论如何我们都必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在转场中，会出现无法交互的情况，切记！
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            失败后，我们要把vc1显示出来
            fromVC.view.hidden = NO;
            然后移除截图视图，因为下次触发present会重新截图
            [tempView removeFromSuperview];
        }
    }];
    
    */
}

- (void)startPopAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    
}

- (void)startCubeAnimation {
    
   
    
}

//截图
- (UIImage *)convertViewToImage:(UIView *)view{
    
    CGSize size = view.bounds.size;
    //下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _imgView.image = [UIImage imageNamed:@"0"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
















