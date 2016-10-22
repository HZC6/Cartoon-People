//
//  MyScrollvView.m
//  LoopScrollview
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "MyScrollvView.h"
#import <UIImageView+WebCache.h>
#import "MyScrollViewController.h"
#define KscW [UIScreen mainScreen].bounds.size.width
#define KscH [UIScreen mainScreen].bounds.size.height

@interface MyScrollvView ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIPageControl *pageControl;
@property(nonatomic, strong)UIImageView *leftImageView;
@property(nonatomic, strong)UIImageView *middleImageView;
@property(nonatomic, strong)UIImageView *rightImageView;
@property(nonatomic, strong)UILabel *leftLabel;
@property(nonatomic, strong)UILabel *middleLabel;
@property(nonatomic, strong)UILabel *rightLabel;
@property(nonatomic, assign)NSInteger currentNumber;

@end

@implementation MyScrollvView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
    }
    
    return self;
}


-(void)setImageNames:(NSMutableArray *)imageNames {
    _imageNames = imageNames;
    
    //创建子控件
    [self creatSubViews];
    //开启定时器
    [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
    //设置手势
    [self setupGesture];
    
    
}
#pragma mark -
#pragma mark - 设置手势
- (void)setupGesture{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
#pragma mark -
#pragma mark - 点击手势
- (void)tapAction:(UITapGestureRecognizer *)tap{
    //if (_pageControl.currentPage == 2) {
        
        //取出根视图控制器
        UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        //取出当前选中的导航控制器
        UINavigationController *Nav = [tabBarVc selectedViewController];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyScrollViewController" bundle:nil];
        MyScrollViewController *myVc = [storyboard instantiateInitialViewController];
        [Nav pushViewController:myVc animated:YES];
    //}
    
    
}

- (void)setLabelNames:(NSMutableArray *)labelNames{
    
    _labelNames = labelNames;
    
    [self loadImage];
}


#pragma mark - 1.创建子视图
-(void)creatSubViews {
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(width * 3, height);
    _scrollView.contentOffset = CGPointMake(width, 0);
    
    [self addSubview:_scrollView];
    
    //创建分页控件
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width-100, self.frame.size.height - 30, 100, 30)];
    
    _pageControl.numberOfPages = _imageNames.count;
    _pageControl.currentPage = 0;
    
    _pageControl.pageIndicatorTintColor = [UIColor orangeColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    _pageControl.userInteractionEnabled = YES;
    [_pageControl addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged];
    
    [self addSubview:_pageControl];
    
    
    //3.创建左中右三个图片视图
    _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _leftImageView.userInteractionEnabled = YES;
    _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width, 0, width, height)];
    _middleImageView.userInteractionEnabled = YES;
    _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(width *2 , 0, width, height)];
    _rightImageView.userInteractionEnabled = YES;
    //创建三个图片上面的label
    _leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,height-30, 250, 30)];
    _leftLabel.textColor = [UIColor whiteColor];
    _leftLabel.font = [UIFont systemFontOfSize:14];
    
    _middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(width+10,height-30 , 250, 30)];
    _middleLabel.textColor = [UIColor whiteColor];
    _middleLabel.font = [UIFont systemFontOfSize:14];
    
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(width*2+10,height-30 , 250, 30)];
    _rightLabel.textColor = [UIColor whiteColor];
    _rightLabel.font = [UIFont systemFontOfSize:14];
    

    [_scrollView addSubview:_leftImageView];
    [_scrollView addSubview:_middleImageView];
    [_scrollView addSubview:_rightImageView];
    
    [_scrollView addSubview:_leftLabel];
    [_scrollView addSubview:_middleLabel];
    [_scrollView addSubview:_rightLabel];
    
    [self loadImage];
}

#pragma mark - 加载图片的方法
-(void)loadImage {
    
    
    [_middleImageView sd_setImageWithURL:_imageNames[_currentNumber] placeholderImage:[UIImage imageNamed:@"默认图片2"]];
    _middleLabel.text = _labelNames[_currentNumber];
    
    
    
    
    NSInteger leftIndex = (_currentNumber - 1 + _imageNames.count) % _imageNames.count;

    [_leftImageView sd_setImageWithURL:_imageNames[leftIndex]placeholderImage:[UIImage imageNamed:@"默认图片2"]];
    _leftLabel.text = _labelNames[leftIndex];
    
    
    NSInteger rightIndex = (_currentNumber + 1) % _imageNames.count;

    [_rightImageView sd_setImageWithURL:_imageNames[rightIndex] placeholderImage:[UIImage imageNamed:@"默认图片2"]];
    _rightLabel.text = _labelNames[rightIndex];
    
}

#pragma mark - 滑动视图的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    //1.判断滑动方向
    if (scrollView.contentOffset.x > scrollView.bounds.size.width) {//向左滑动
        
        _currentNumber = (_currentNumber + 1) % _imageNames.count;
        
    }else if(scrollView.contentOffset.x < scrollView.bounds.size.width){ //向右滑动
        _currentNumber = (_currentNumber - 1 + _imageNames.count) % _imageNames.count;
        
    }
    
    [self loadImage];
    _pageControl.currentPage = _currentNumber;
    scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
    
    
    
    
}

#pragma mark -  pagecontrol监听方法的实现
- (void)turnPage{
    NSInteger page = _pageControl.currentPage;
    _currentNumber = page;
    [self loadImage];
    _scrollView.contentOffset = CGPointMake(_scrollView.bounds.size.width, 0);
}

#pragma mark - 定时器的监听方法
- (void)runTime{
    
    NSInteger page = _pageControl.currentPage;
    page ++;
    page = page > _imageNames.count-1 ? 0 : page ;
    _pageControl.currentPage = page;
    [self turnPage];
}


@end
