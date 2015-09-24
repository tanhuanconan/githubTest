//
//  ViewController.m
//  0923Gesture
//
//  Created by apple on 15/9/23.
//  Copyright © 2015年 orange. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    UIPanGestureRecognizer *panG;
    UIScrollView *scrollV;
    UIImage *redimage;
    UIImageView *redIV;
}
@end

@implementation ViewController
#if 0
-(void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTap:)];
    tapGesture.numberOfTapsRequired = 2;
    //tapGesture.numberOfTouchesRequired = 3;
   // [self.view addGestureRecognizer:tapGesture];
    //swip滑动
    UISwipeGestureRecognizer *swipGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(didSwip:)];
    //方向
    swipGesture.numberOfTouchesRequired = 2;
//    swipGesture.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:swipGesture];
    //长按
    UILongPressGestureRecognizer *longP = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didPress:)];
    //识别⻓长按的最⼩小时⻓长,默认为0.5s
    longP.minimumPressDuration = 1;
    //识别前可以移动的最⼤大距离,允许的误差范围;
    longP.allowableMovement = 20;
    [self.view addGestureRecognizer:longP];
    //拖动
    panG = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPan:)];
    [self.view addGestureRecognizer:panG];
    //定时器
    //[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timeout:) userInfo:nil repeats:NO];
    
    
}
-(void)timeout:(id)no
{   //让手势失效
    panG.enabled = NO;
}
-(void)didTap:(UIGestureRecognizer *)recognizer
{
    NSLog(@"%s,点击",__PRETTY_FUNCTION__);
}
-(void)didSwip:(UISwipeGestureRecognizer *)recognizer
{
    NSLog(@"滑动:%@,%lu",recognizer,(unsigned long)recognizer.numberOfTouches);
}
-(void)didPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"触摸开始");
    }else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        NSLog(@"触摸移动");
    }else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"触摸结束");
    }else
    {
        NSLog(@"----");
    }
}
-(void)didPan:(UIPanGestureRecognizer *)gesture
{
    //移动的距离,矢量
    CGPoint translation = [gesture translationInView:self.view];
    NSLog(@"距离: %@", NSStringFromCGPoint(translation));
    //移动的速度,分量,
    CGPoint velocity = [gesture velocityInView:self.view];
    NSLog(@"速度: %@", NSStringFromCGPoint(velocity));
}
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#endif
#pragma mark 手势操作的方法的系统显示
-(void)viewDidLoad
{
    [super viewDidLoad];
    CGSize size = self.view.bounds.size;
    self.view.backgroundColor = [UIColor yellowColor];
    //滚动框
    scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    scrollV.backgroundColor = [UIColor greenColor];
    //视图框
    UIView *redV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width,size.height)];
    redV.backgroundColor = [UIColor redColor];
    redimage = [UIImage imageNamed:@"111.jpg"];
    redIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50 ,50)];
    redIV.image  = redimage;
    scrollV.minimumZoomScale = 0.1;
    scrollV.maximumZoomScale = 20;
    UIView *purpleV = [[UIView alloc]initWithFrame:CGRectMake(size.width, 0, size.width, size.height)];
    purpleV.backgroundColor = [UIColor purpleColor];
    //加入滚动框
    [scrollV addSubview:redV];
    [scrollV addSubview:redIV];
    
    [scrollV addSubview:purpleV];
    scrollV.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //滚动框默认大小为0,必须设置才有效果;
    scrollV.contentSize = CGSizeMake(size.width*2, size.height);
    scrollV.delegate = self;
    scrollV.pagingEnabled = YES;
   // [scrollV.panGestureRecognizer addTarget:self action:@selector(didPan:)];
    [self.view addSubview:scrollV];
    //KVO观察
  //  [scrollV addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    
}
//KVO方法实现
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"位置:%@", change);
}
//手势显示
-(void)didPan:(UIPanGestureRecognizer *)gesture
{
    NSLog(@"手势显示:%@",NSStringFromCGPoint(scrollV.contentOffset));
}
//只要contentOffset发⽣生改变就会调⽤用
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    //NSLog(@":%@",NSStringFromCGPoint(scrollV.contentOffset));
//}
//开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
   // NSLog(@":%@",NSStringFromCGPoint(scrollV.contentOffset));
    NSLog(@"开始拖动");
}
//结束拖动,通过decelerate参数判断是否在减速(静⽌)
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:
(BOOL)decelerate
{
    NSLog(@"即将结束:%@",decelerate?@"减速中":@"已经静止");
}
//开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"开始减速");
}
//停⽌止减速(静⽌止)
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"停止减速");
}
//是否允许点击顶部状态栏(同⼀一个⻚页⾯面,只能有⼀一个scrollView返回YES)
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView
*)scrollView
{
    return YES;
}
//已经滚动到顶部
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"滚动到顶部");
}
//图片缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return redIV;
}
@end
