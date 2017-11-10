//
//  AniViewController.m
//  test
//
//  Created by mac1 on 2017/11/3.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "AniViewController.h"
#import "AniPushViewController.h"

@interface AniViewController ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *aniButton;

@end

@implementation AniViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imgView];
    
    [self.view addSubview:self.aniButton];
    
    
    //手势
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGestureRecognizerClick:)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipe];
    
}

- (void)swipeGestureRecognizerClick:(UISwipeGestureRecognizer *)swipe {
    
    CATransition *transition = [[CATransition alloc]init];
    
    /* The name of the transition. Current legal transition types include
     * `fade', `moveIn', `push' and `reveal'. Defaults to `fade'. */
    /**
     *   1.#define定义的常量
     kCATransitionFade   交叉淡化过渡  默认
     kCATransitionMoveIn 新视图移到旧视图上面,覆盖原图
     kCATransitionPush   新视图把旧视图推出去  ,推出
     kCATransitionReveal 将旧视图移开,显示下面的新视图 ,从底部显示
     
     2.用字符串表示
     pageCurl            向上翻一页
     pageUnCurl          向下翻一页
     rippleEffect        滴水效果
     suckEffect          收缩效果，如一块布被抽走
     cube                立方体效果
     oglFlip             上下翻转效果
     注意：
     还有很多私有API效果，使用的时候要小心，可能会导致app审核不被通过（）
     fade     //交叉淡化过渡(不支持过渡方向)
     push     //新视图把旧视图推出去
     moveIn   //新视图移到旧视图上面
     reveal   //将旧视图移开,显示下面的新视图
     cube     //立方体翻滚效果
     oglFlip  //上下左右翻转效果
     suckEffect   //收缩效果，如一块布被抽走(不支持过渡方向)
     rippleEffect //滴水效果(不支持过渡方向)
     pageCurl     //向上翻页效果
     pageUnCurl   //向下翻页效果
     cameraIrisHollowOpen  //相机镜头打开效果(不支持过渡方向)
     cameraIrisHollowClose //相机镜头关上效果(不支持过渡方向)
     
     */
    //设置动画类型，注意对于苹果官方没有公开的动画类型智能使用字符串，并没有对应的常量意义
    // transaction.type=@"pageCurl";//控制图片的滑动类型
    
    transition.type = @"cube";
    
    transition.subtype = kCATransitionFromRight;
    
    transition.duration = 0.8;
    
    self.imgView.image = [self trasitionImage];
    
    [self.imgView.layer addAnimation:transition forKey:@"trasition"];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

- (UIImage *)trasitionImage {
    
    int random = arc4random() % 5;
    
    return [UIImage imageNamed:[NSString stringWithFormat:@"%d", random]];
}

- (void)present {
    
    AniPushViewController *pushVC = [[AniPushViewController alloc]init];
    
    [self presentViewController:pushVC animated:YES completion:nil];
}

-(UIButton *)aniButton {
    
    if (!_aniButton) {
        
        _aniButton = [[UIButton alloc]initWithFrame:CGRectMake(250, 500, 65, 30)];
        [_aniButton setTitle:@"戳我呀" forState:UIControlStateNormal];
        [_aniButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _aniButton.titleLabel.font = [UIFont systemFontOfSize:20];
        [_aniButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    }
    return _aniButton;
}

- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imgView.image = [UIImage imageNamed:@"0"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end
