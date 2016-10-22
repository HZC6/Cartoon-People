//
//  BaseNavigationController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:243/255.0 blue:87/255.0 alpha:1];
    
}
// 重写push方法, 用来拦截push进来的视图
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 这里判断是否进入push视图
    if (self.childViewControllers.count > 0) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateHighlighted];
        btn.frame = CGRectMake(40, 10, 70, 40);
        // 设置按钮内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 内边距
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        // 隐藏tabTar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这里写在下面，给外面权利修改按钮
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回(Pop)
- (void)backAction {
    [self popViewControllerAnimated:YES];
}


@end
