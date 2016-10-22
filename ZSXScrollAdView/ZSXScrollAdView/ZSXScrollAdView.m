//
//  ZSXScrollAdView.m
//  ZSXScrollAdView
//
//  Created by qianfeng on 2016/10/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ZSXScrollAdView.h"


@interface ZSXScrollAdView ()<UIScrollViewDelegate>
{
    dispatch_queue_t _currentQueue;
}

@property (nonatomic, assign)NSInteger currentPage;

@property (nonatomic, weak)UIPageControl *pageControl;

@property (nonatomic, weak)NSTimer *timer;

@property (nonatomic, weak)UIScrollView *scrollView;

@end

@implementation ZSXScrollAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.timeInterval = 1;
        self.scrollAnimateDuration = 0.3;
        self.timeNeed = YES;
        self.pageControlNeed = YES;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame images:(NSArray<UIImage *> *)images {
    if (self = [super initWithFrame:frame]) {
        self.timeInterval = 1;
        self.scrollAnimateDuration = 0.3;
        self.timeNeed = YES;
        self.pageControlNeed = YES;
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.images = images;
    }
    return self;
}

- (void)setImages:(NSArray *)images {
    
    _images = images;
    
    [self createImageViews];
    [self pageControl];
    if (self.isTimeNeed) {
        [self timer];
    }
}

- (NSTimer *)timer {
    if (!_timer) {
        //创建定时器前先删除，可以防止多次创建
        [_timer invalidate];
        //创建定时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:_timeInterval target:self selector:@selector(imageScroll) userInfo:nil repeats:YES];
        //添加到当前RunLoop中，设置模式为NSRunLoopCommonModes，可以防止滑动界面的时候定时器停止
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        _timer = timer;
    }
    return _timer;
}

//滚动动画
- (void)imageScroll {
    self.currentPage++;
    
    [UIView animateWithDuration:self.scrollAnimateDuration animations:^{
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width*(_currentPage+1), 0);
    }];
    if (self.currentPage == self.images.count) {
        self.currentPage = 0;
        self.scrollView.contentOffset = CGPointMake(self.frame.size.width*(_currentPage+1), 0);
        ;
    }
    self.pageControl.currentPage = self.currentPage;
}

#pragma mark - UIScrollViewDelegate
//设置代理轮动完成后触发
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger offSet = scrollView.contentOffset.x;
    if (offSet == self.frame.size.width*(self.images.count+1)) {
        offSet = self.frame.size.width;
        self.scrollView.contentOffset = CGPointMake(offSet, 0);
        self.currentPage = 0;
    } else if (offSet == 0) {
        offSet = self.frame.size.width*self.images.count;
        self.scrollView.contentOffset = CGPointMake(offSet, 0);
        self.currentPage = self.images.count - 1;
    } else {
        self.scrollView.contentOffset = CGPointMake(offSet, 0);
        self.currentPage = offSet/self.frame.size.width - 1;
    }
    self.pageControl.currentPage = self.currentPage;
}

#pragma mark - 懒加载
- (void)createImageViews {
    for (NSInteger i = 0; i < _images.count + 2; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        //创建self.images.count + 2个imageView，为了实现左右滑动无缝连接，除了正常的图片之外，在第一张之前加上最后一张，在最后一张后加上第一张
        if (i == 0) {
            imageView.image = _images[_images.count-1];
        } else if (i == _images.count + 1) {
            imageView.image = _images[0];
        } else {
            imageView.image = _images[i - 1];
        }
        [self.scrollView addSubview:imageView];
    }

}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        //初始contentOffset为self.frame.size.width
        scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        scrollView.contentSize = CGSizeMake(self.frame.size.width*(_images.count+2), self.frame.size.height);
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        scrollView.delegate = self;
        
        [self addSubview:scrollView];
        
        _scrollView = scrollView;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        pageControl.numberOfPages = self.images.count;
        
        self.currentPage = 0;
        
        pageControl.hidden = !self.isPageControlNeed;
        
        pageControl.currentPage = self.currentPage;
        
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:self.images.count];
        
        pageControl.frame = CGRectMake((self.frame.size.width - pageControlSize.width)/2, self.frame.size.height - 50, pageControlSize.width, pageControlSize.height);
        
        [self addSubview:pageControl];
        
        _pageControl = pageControl;
        
    }
    return _pageControl;
}

@end
