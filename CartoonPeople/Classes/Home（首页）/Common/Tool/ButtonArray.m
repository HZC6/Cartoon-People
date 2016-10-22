//
//  ButtonArray.m
//  按钮动画
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 LiuChao. All rights reserved.
//

#import "ButtonArray.h"
#import "MyBurtton.h"
@implementation ButtonArray
- (NSMutableArray *)backButtonArrayUIView:(id)view index:(NSInteger)index array:(NSArray *)data{
    NSMutableArray *arry = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        MyBurtton *button = [[MyBurtton alloc]initWithFrame:CGRectMake(40, 40, 5, 5)];
        button.layer.cornerRadius = 2.5;
        button.layer.masksToBounds = YES;
        button.userInteractionEnabled = YES;
        [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",data[i]]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.hidden = YES;
        button.tag = index+i;
        [view addSubview:button];
        [arry addObject:button];
        }
    return arry;
}


@end
