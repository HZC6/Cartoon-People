//
//  CircleViewController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CircleViewController.h"
#import "HotCircleTableViewController.h"
#import "HotPostTableViewController.h"
#import "JoinViewController.h"
#import "UIView+Frame.h"
#define kscW  [UIScreen mainScreen].bounds.size.width


@interface CircleViewController () <UIScrollViewDelegate>
/** 用来存放所有子控制器view的scrollView */
@property (nonatomic, weak) UIScrollView *scrollView;
/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) UIButton *previousClickedTitleButton;



@end

@implementation CircleViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
    //标签栏不隐藏
    self.tabBarController.tabBar.hidden = NO;
    
   
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 初始化子控制器
    [self setupAllChildVcs];
    
    // scrollView
    [self setupScrollView];
    
    // 标题栏
    [self setupTitlesView];
    
    // 添加第0个子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
    //设置导航栏背景颜色
    self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
    
 
}

/**
 *  初始化子控制器
 */
- (void)setupAllChildVcs
{
    [self addChildViewController:[[HotCircleTableViewController alloc] init]];
    [self addChildViewController:[[HotPostTableViewController alloc] init]];
    [self addChildViewController:[[JoinViewController alloc] init]];

}


/**
 *  scrollView
 */
- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    //self.navigationController.navigationBar.translucent = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //scrollView.frame = [UIScreen mainScreen].bounds;
    scrollView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollsToTop = NO; // 点击状态栏的时候，这个scrollView不会滚动到最顶部
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加子控制器的view
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.zc_width;
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}

/**
 *  标题栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    //titlesView.backgroundColor = [UIColor whiteColor];
    titlesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"搜索框底图"]];
    titlesView.frame = CGRectMake(0, 64, kscW, 30);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 标题栏按钮
    [self setupTitleButtons];
    
    // 标题下划线
    [self setupTitleUnderline];
}

/**
 *  标题栏按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"热门圈子", @"热门帖子", @"加入"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.zc_width / count;
    CGFloat titleButtonH = self.titlesView.zc_height;
    
    // 创建3个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
}

/**
 *  标题下划线
 */
- (void)setupTitleUnderline
{
    // 标题按钮
    UIButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.zc_height = 2;
    titleUnderline.zc_y = self.titlesView.zc_height - titleUnderline.zc_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.zc_width = firstTitleButton.titleLabel.zc_width + 10;
    self.titleUnderline.zc_centerX = firstTitleButton.zc_centerX;
}

#pragma mark - 监听
/**
 *  点击标题按钮
 */
- (IBAction)titleButtonClick:(UIButton *)titleButton
{
    
    // 处理标题按钮点击
    [self dealTitleButtonClick:titleButton];
}

/**
 *  处理标题按钮点击
 */
- (void)dealTitleButtonClick:(UIButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    NSUInteger index = titleButton.tag;
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        self.titleUnderline.zc_width = titleButton.titleLabel.zc_width + 10;
        self.titleUnderline.zc_centerX = titleButton.zc_centerX;
        
        // 滚动scrollView
        CGFloat offsetX = self.scrollView.zc_width * index;
        self.scrollView.contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        // 添加子控制器的view
        [self addChildVcViewIntoScrollView:index];
    }];
    
    // 设置index位置对应的tableView.scrollsToTop = YES， 其他都设置为NO
    for (NSUInteger i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *childVc = self.childViewControllers[i];
        // 如果view还没有被创建，就不用去处理
        if (!childVc.isViewLoaded) continue;
        
        UIScrollView *scrollView = (UIScrollView *)childVc.view;
        if (![scrollView isKindOfClass:[UIScrollView class]]) continue;
        
        scrollView.scrollsToTop = (i == index);
    }
}

#pragma mark - <UIScrollViewDelegate>
/**
 *  当用户松开scrollView并且滑动结束时调用这个代理方法（scrollView停止滚动的时候）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 求出标题按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.zc_width;
    
    // 点击对应的标题按钮
    UIButton *titleButton = self.titlesView.subviews[index];
    //    [self titleButtonClick:titleButton];
    [self dealTitleButtonClick:titleButton];
}

#pragma mark - 其他
/**
 *  添加第index个子控制器的view到scrollView中
 */
- (void)addChildVcViewIntoScrollView:(NSUInteger)index
{
    UIViewController *childVc = self.childViewControllers[index];
    
    // 如果view已经被加载过，就直接返回
    if (childVc.isViewLoaded) return;
    
    // 取出index位置对应的子控制器view
    UIView *childVcView = childVc.view;
    
    // 设置子控制器view的frame
    CGFloat scrollViewW = self.scrollView.zc_width;
    childVcView.frame = CGRectMake(index * scrollViewW, 0, scrollViewW, self.scrollView.zc_height);
    // 添加子控制器的view到scrollView中
    [self.scrollView addSubview:childVcView];
}
@end
