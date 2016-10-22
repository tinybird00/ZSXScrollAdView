//
//  ZSXScrollAdView.h
//  ZSXScrollAdView
//
//  Created by qianfeng on 2016/10/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZSXScrollAdView : UIView

@property (nonatomic, strong)NSArray<UIImage *> *images;
//定时器执行时间间隔，默认为一秒
@property (nonatomic, assign)NSInteger timeInterval;
//滚动动画持续时间，默认0.3秒
@property (nonatomic ,assign)NSInteger scrollAnimateDuration;
//YES为有定时器，NO为没有定时器，默认有定时器
@property (nonatomic, getter=isTimeNeed)BOOL timeNeed;
//默认YES,有pageControl
@property (nonatomic, getter=isPageControlNeed)BOOL pageControlNeed;

- (instancetype)initWithFrame:(CGRect)frame;

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<UIImage *> *) images;



@end
