//
//  CPLoopImageView.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CPImageLoopDelegate ;

@interface CPLoopImageView : UIView

/** 当前页 */
@property (nonatomic, assign) NSInteger currentPage;
/** 图片 */
@property (nonatomic, strong) NSMutableArray *imageArray;
/** 滑动视图 */
@property (nonatomic, readonly, strong) UIScrollView *scrollView;
/** 分页控件 */
@property (nonatomic, readonly, strong) UIPageControl *pageControl;
/** 时间间隔 */
@property (nonatomic, assign) NSInteger timeInterval;

@property (nonatomic, assign) id <CPImageLoopDelegate>delegate;
/** 是否开启自动轮播 */
@property (nonatomic, assign) BOOL isAutoScroll;

@end

//协议
@protocol CPImageLoopDelegate <NSObject>

@optional

- (void)didClickPage:(CPLoopImageView *)view atIndex:(NSInteger)index;

@end

