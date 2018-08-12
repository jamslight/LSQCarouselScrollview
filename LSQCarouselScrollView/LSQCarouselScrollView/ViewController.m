//
//  ViewController.m
//  LSQCarouselScrollView
//
//  Created by define on 2018/8/12.
//  Copyright © 2018年 刘绍强. All rights reserved.
//
#define WIDTH  [UIScreen mainScreen].bounds.size.width
#define HEIGHT 200

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIImageView *visibleView;

@property (nonatomic,strong)UIImageView *reuseView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    scrollView.contentSize = CGSizeMake(WIDTH * 3, HEIGHT);
    scrollView.contentOffset = CGPointMake(WIDTH, 0);
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    _scrollView = scrollView;
    [self.view addSubview:scrollView];
    
//    创建重用Iv
    UIImageView *iv1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    iv1.backgroundColor = [UIColor cyanColor];
    _reuseView = iv1;
    [_scrollView addSubview:iv1];
    
//   创建可视Iv
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(WIDTH, 0, WIDTH, 200)];
    iv.backgroundColor = [UIColor whiteColor];
    iv.image = [UIImage imageNamed:@"001"];
    iv.tag = 1;
    _visibleView = iv;
    [_scrollView addSubview:iv];

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
 
//    获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = WIDTH;
    
    CGRect f = _reuseView.frame;
    NSInteger index = 0;
    
    if (offsetX > WIDTH) {
//        左滑
        f = CGRectMake(scrollView.contentSize.width - WIDTH, 0,WIDTH , HEIGHT);
        
        index = _visibleView.tag + 1;
        if (index > 5) {index = 1;}
    }else{
//        右滑
        f = CGRectMake(0, 0, WIDTH, HEIGHT);
        
        index = _visibleView.tag - 1;
        if (index < 1) {index = 5;}
    }
    
    _reuseView.frame = f;
    _reuseView.tag = index;
    _reuseView.image = [UIImage imageNamed:[NSString stringWithFormat:@"00%ld",index]];
    
    
    NSLog(@"----%ld",offsetX);
    
    if (offsetX <= 0 || offsetX >= WIDTH *2) {
        
        UIImageView *temp = _visibleView;
        _visibleView = _reuseView;
        _reuseView = temp;
        
//        交换显示位置
        _visibleView.frame = _reuseView.frame ;
        
//
        _scrollView.contentOffset = CGPointMake(WIDTH, 0);
    }
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
