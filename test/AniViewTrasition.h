//
//  AniViewTrasition.h
//  test
//
//  Created by mac1 on 2017/11/3.
//  Copyright © 2017年 mac1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AniViewTrasitionType) {
    
    AniViewTrasitionTypePush = 0,
    AniViewTrasitionTypePop
};

@interface AniViewTrasition : NSObject <UIViewControllerAnimatedTransitioning>

///过渡动画管理的类型 pop / push
@property (nonatomic, assign) AniViewTrasitionType type;

+ (instancetype)trasitionWithType:(AniViewTrasitionType)type;

- (instancetype)initWithTrasitionType:(AniViewTrasitionType)type;

@end
