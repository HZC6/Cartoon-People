//
//  UIView+Extension.h
//  百思不得姐
//
//  Created by lxy on 16/5/9.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;


/**
 *  判断一个控件是否真正显示在主窗口上
 */

- (BOOL)isShowingOnKeyWindow;

@end
