//
//  BookcaseViewController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 lc. All rights reserved.
//

#import "BookcaseViewController.h"
#import "CPHistoryViewController.h"
#import "CPCollectViewController.h"
#import "CPDownloadViewController.h"
#import "CPSlideView.h"
#import "ButtonArray.h"
#import "MyBurtton.h"

@interface BookcaseViewController (){
    NSMutableArray *arry;
    NSInteger index;
}


@end

@implementation BookcaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CPCollectViewController *collectVc = [[CPCollectViewController alloc] init];
    CPHistoryViewController *historyVc = [[CPHistoryViewController alloc] init];
    CPDownloadViewController *downloadVc = [[CPDownloadViewController alloc] init];
    NSArray *slideArray = @[@{@"收藏" : collectVc}, @{@"历史" : historyVc}, @{@"下载" : downloadVc}];
    CPSlideView *slideView = [[CPSlideView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight) WithViewControllers:slideArray];
    [self.view addSubview:slideView];
    
    NSArray *array = @[@"分享有礼",@"基友圈",@"系统消息",@"意见反馈",@"游戏中心"];
    index = 1;
    arry = [NSMutableArray array];
    ButtonArray *btArray = [[ButtonArray alloc]init];
    arry = [btArray backButtonArrayUIView:self.view index:1000 array:array];
    MyBurtton *btn = [[MyBurtton alloc]initWithFrame:CGRectMake(20, kScreenHeight-60-49, 40, 40)];
    CGPoint point = CGPointMake(20, kScreenHeight-60-49);
    [btn createButton:point tag:2000 View:self.view];
    
}

- (void)Action:(UIButton *)btn{
    CGPoint  point = CGPointMake(40, kScreenHeight - 40-49);
    if (index == 1) {
        [UIView animateWithDuration:5 animations:^{
            for (int i = 0; i < arry.count; i++) {
                MyBurtton *button = arry[i];
                button.hidden = NO;
                [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
                [button animationDirection:@"rightUp" Index:i Number:arry.count Point:point];
            }
            
        } completion:^(BOOL finished) {
            for (int i = 0; i < arry.count; i++) {
                MyBurtton *button = arry[i];
                button.frame = CGRectMake(40+90*cos(M_PI*i/8), kScreenHeight - 40-49-90*sin(M_PI*i/8), 5, 5);
            }
        }];
    }
    if (index == 2) {
        [UIView animateWithDuration:5 animations:^{
            for (int i = 0; i < arry.count; i++) {
                MyBurtton *button = arry[i];
                button.tag = 1000+i;
                [button animationDirection:@"back" Index:i Number:arry.count Point:point];
            }
        } completion:^(BOOL finished) {
            for (int i = 0; i < arry.count; i++) {
                MyBurtton *button = arry[i];
                button.frame = CGRectMake(40, kScreenHeight-40, 5, 5);
            }
        }];
        
        
        
        index = 0;
    }
    index++;
}

- (void)back:(MyBurtton *)btn {
    NSLog(@"123");
    CGPoint  point;
    NSMutableArray *array = [NSMutableArray array];
    point = CGPointMake(40, kScreenHeight-40-49);
    array = arry;
    
    [UIView animateWithDuration:5 animations:^{
        for (int i = 0; i < array.count; i++) {
            MyBurtton *button = array[i];
            
            [button animationDirection:@"back" Index:i Number:array.count Point:point];
        }
    } completion:^(BOOL finished) {
        for (int i = 0; i < array.count; i++) {
            MyBurtton *button = array[i];
            button.frame = CGRectMake(40, kScreenHeight-40, 5, 5);
        }
    }];
    
    index = 1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
