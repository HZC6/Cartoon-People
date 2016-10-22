//
//  MyBurtton.h
//  按钮动画
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 LiuChao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyBurtton : UIButton
- (void)createButton:(CGPoint)point tag:(NSInteger)tag View:(id)view;

- (void)animationDirection:(NSString *)Direction Index:(int)index Number:(NSInteger)number Point:(CGPoint)point;

@end
