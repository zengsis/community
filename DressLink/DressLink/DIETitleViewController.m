//
//  DIETitleViewController.m
//  DressLink
//
//  Created by apple on 15/10/24.
//  Copyright © 2015年 devein. All rights reserved.
//

#import "DIETitleViewController.h"
#import "TitleCommunityView.h"
#import "DIECommunityViewController.h"
#import "DIELoggingViewController.h"

@interface DIETitleViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    NSArray *_pageArray;
    NSInteger _currentIndex;
    TitleCommunityView *_titleView;
}

@end

@implementation DIETitleViewController

- (instancetype)init
{
    return [self initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
}


- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options
{
    if (self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options]) {
        self.dataSource = self;
        self.delegate = self;
        //init the page array
        [self createPageControllers];
        [self setViewControllers:@[[_pageArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return  self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _titleView = [[TitleCommunityView alloc]initWithFrame:CGRectMake(0, 0, 120, 44)];
    [_titleView addTarget:self action:@selector(titleViewValueChanged:) forControlEvents:UIControlEventValueChanged];
    _titleView.titleArray = @[@"AllPost",@"MyPost"];
    self.navigationItem.titleView = _titleView;
    
    for (UIView *v in self.view.subviews) {
        if ([v isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)v;
            v.superview.backgroundColor = [UIColor whiteColor];
            [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
        }
    }
    
}

- (void)titleViewValueChanged:(TitleCommunityView *)sender
{
    if (sender.selectedIndex == 0) {
        [self setViewControllers:@[[_pageArray objectAtIndex:sender.selectedIndex]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:nil];
    }else{
        [self setViewControllers:@[[_pageArray objectAtIndex:sender.selectedIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}



#pragma mark  create pageviews (红色，绿色界面)
- (void)createPageControllers {
    UIViewController  *AllPostViewController = [DIECommunityViewController new];
    AllPostViewController.view.backgroundColor = [UIColor redColor];
    UIViewController *communityViewController = [DIELoggingViewController new];
    communityViewController.view.backgroundColor = [UIColor greenColor];
    //需要显示的页面，当页面比较多的时候，可以考虑动态创建
    _pageArray = @[AllPostViewController, communityViewController];
}



#pragma mark UIPageViewController DataSource
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    //获取当前页面的位置
    if ([_pageArray indexOfObject:viewController]) {
        return _pageArray[0];
    }
    else {
        return nil;
    }
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([_pageArray indexOfObject:viewController]) {
        return nil;
    }
    else {
        return _pageArray[1];
    }
}

#pragma mark UIPageViewController Delegate
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
{
    UIViewController *currentViewController = [pageViewController.viewControllers firstObject];
    _currentIndex =  [_pageArray indexOfObject:currentViewController];
    _titleView.selectedIndex = _currentIndex;
}

//翻页位置（左、中、右）
- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return UIPageViewControllerSpineLocationMin;
}

//如果为滚动翻页，实现下面两个方法后，会显示UIPageControl指示页面
//总页数
- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}
//当前页号
- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return [_pageArray indexOfObject:pageViewController.viewControllers.firstObject];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    UIScrollView *scrollView = (UIScrollView *)object;
    
    NSValue *value = change[NSKeyValueChangeNewKey];
    CGPoint v = value.CGPointValue;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //UIPageViewController机制使用了三个页面，当前页处于中间
    //当显示第0页，并且继续右拖时，中断scrollView上手势的识别
    if (_currentIndex == 0 && v.x <= width) {
        scrollView.panGestureRecognizer.enabled = NO;
        scrollView.panGestureRecognizer.enabled = YES;
    }
}

@end
