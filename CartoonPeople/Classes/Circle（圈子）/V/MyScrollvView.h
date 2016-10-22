//
//  MyScrollvView.h
//  LoopScrollview
//
//  Created by mac1 on 16/7/17.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyScrollvView : UIView<UIScrollViewDelegate>

//1.属性
//图片数组
@property(nonatomic,strong)NSMutableArray *imageNames;
//label名字数组
@property(nonatomic,strong)NSMutableArray *labelNames;

@end
