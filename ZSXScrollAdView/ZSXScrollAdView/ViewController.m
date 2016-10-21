//
//  ViewController.m
//  ZSXScrollAdView
//
//  Created by qianfeng on 2016/10/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "ViewController.h"
#import "ZSXScrollAdView.h"

@interface ViewController ()

@end

#define kImageViewWidth 307
#define kImageViewHeight 557
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *images = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 6; i++) {
        NSString *name = [NSString stringWithFormat:@"Irelia_%ld.jpg",i];
        UIImage *image = [UIImage imageNamed:name];
        [images addObject:image];
    }
    
    
    ZSXScrollAdView *adView = [[ZSXScrollAdView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - kImageViewWidth)/2, 20, kImageViewWidth, 557) images:images];
    
    [self.view addSubview:adView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
