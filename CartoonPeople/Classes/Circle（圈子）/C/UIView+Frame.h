//
//  UIView+Frame.h
//  Budejie
//
//  Created by mac1 on 16/8/20.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

//写分类：避免跟其他开发者发生冲突，加前缀


@property CGFloat zc_width;
@property CGFloat zc_height;
@property CGFloat zc_x;
@property CGFloat zc_y;
@property CGFloat zc_centerX;
@property CGFloat zc_centerY;

@end
