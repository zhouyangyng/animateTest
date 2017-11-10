  //
//  AniPushViewController.m
//  test
//
//  Created by mac1 on 2017/11/3.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import "AniPushViewController.h"
#import "AniViewTrasition.h"

@interface AniPushViewController ()<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation AniPushViewController

-(instancetype)init {
    
    if (self = [super init]) {
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.imgView];
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [AniViewTrasition trasitionWithType:AniViewTrasitionTypePush];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return [AniViewTrasition trasitionWithType:AniViewTrasitionTypePop];
}

- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        _imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _imgView.image = [UIImage imageNamed:@"2"];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

@end



