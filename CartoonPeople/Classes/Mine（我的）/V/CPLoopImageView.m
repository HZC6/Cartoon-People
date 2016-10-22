//
//  CPLoopImageView.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPLoopImageView.h"

@interface CPLoopImageView() <UIScrollViewDelegate>

/** 左边view */
@property (nonatomic, strong) UIView *firstView;
/** 中间view */
@property (nonatomic, strong) UIView *middleView;
/** 右边view */
@property (nonatomic, strong) UIView *lastView;

@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

/** 定时器 */
@property (nonatomic, strong) NSTimer *autoScrollTimer;

@property (nonatomic) BOOL isDragging;

/** 是否是第一次进入 */
@property (nonatomic) BOOL isFristGo;

@end

@implementation CPLoopImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self _Init];
    }
    return self;
    
}

- (void)_Init{
    
    //默认TimeInterval
    self.timeInterval = 2;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 30, kScreenWidth, 30)];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    //设置单击手势
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    _tapGesture.numberOfTapsRequired = 1;
    _tapGesture.numberOfTouchesRequired = 1;
    [_scrollView addGestureRecognizer:_tapGesture];
    
}

#pragma mark 单击手势
-(void)handleTap:(UITapGestureRecognizer*)sender
{
    // 判断代理有没有这个方法
    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:_currentPage];
    }
}

-(void)setImageArray:(NSMutableArray *)imageArray
{
    if (imageArray) {
        _imageArray = imageArray;
        _currentPage = 0; //默认为第0页
        _pageControl.numberOfPages = _imageArray.count;
    }
    [self reloadData];
}

-(void)reloadData{
    
    [_firstView removeFromSuperview];
    [_middleView removeFromSuperview];
    [_lastView removeFromSuperview];
    
    //从数组中取到对应的图片view加到已定义的三个view中
    if (_currentPage == 0) {
        
        _firstView = [_imageArray lastObject];
        _middleView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray objectAtIndex:_currentPage+1];
        
    } else if (_currentPage == _imageArray.count-1) {
        
        _firstView = [_imageArray objectAtIndex:_currentPage-1];
        _middleView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray firstObject];
        
    } else {
        
        _firstView = [_imageArray objectAtIndex:_currentPage-1];
        _middleView = [_imageArray objectAtIndex:_currentPage];
        _lastView = [_imageArray objectAtIndex:_currentPage+1];
        
    }
    
    //设置三个view的frame，加到scrollview上
    _firstView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    _middleView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, 200);
    _lastView.frame = CGRectMake(kScreenWidth*2, 0, kScreenWidth, 200);
    
    [_scrollView addSubview:_firstView];
    [_scrollView addSubview:_middleView];
    [_scrollView addSubview:_lastView];
    
    //设置当前的分页
    _pageControl.currentPage = _currentPage;
    
    
    //获取前一张的背景,设置_ScrollView的背景颜色
    UIImageView *currentView = (UIImageView*)self.imageArray[_currentPage];
    _scrollView.backgroundColor = [UIColor colorWithPatternImage:currentView.image];
    
    
    //第一次进入，不需要切换的动画，直接设置默认的为currentPage的image
    
    if (_isFristGo) {
        
        if (!self.isDragging) {
            
            _scrollView.contentOffset = CGPointMake(0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            } completion:^(BOOL finished) {
            }];
            
        } else {
            _scrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            self.isDragging = NO;
        }
        
    }
    
    _isFristGo = YES;
}

-(void)setTimeInterval:(NSInteger)timeInterval
{
    _timeInterval = timeInterval;
}

#pragma mark scrollvie停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动时候暂停自动替换
    [_autoScrollTimer invalidate];
    _autoScrollTimer = nil;
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
    
    //得到当前页数
    float x = _scrollView.contentOffset.x / kScreenWidth;
    
    //往前翻
    if (x <= 0) {
        if (_currentPage-1 < 0) {
            _currentPage = _imageArray.count-1;
        }else{
            _currentPage --;
        }
    }
    //往后翻
    if (x >= 2) {
        if (_currentPage == _imageArray.count-1) {
            _currentPage = 0;
        }else{
            _currentPage ++;
        }
    }
    
    self.isDragging = YES;
    
    [self reloadData];
    
}

-(void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    
    if (isAutoScroll) {
        if (!_autoScrollTimer) {
            _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(autoShowNextImage) userInfo:nil repeats:YES];
        }
    }else {
        if (_autoScrollTimer.isValid) {
            [_autoScrollTimer invalidate];
            _autoScrollTimer = nil;
        }
        
    }
    
}
#pragma mark 展示下一页
-(void)autoShowNextImage
{
    if (_currentPage == _imageArray.count-1) {
        _currentPage = 0;
    }else{
        _currentPage ++;
    }
    
    [self reloadData];
}


@end
