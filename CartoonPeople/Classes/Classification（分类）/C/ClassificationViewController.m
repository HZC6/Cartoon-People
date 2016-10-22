//
//  ClassificationViewController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 lc. All rights reserved.
//

#import "ClassificationViewController.h"
#import "CPThemeViewController.h"
#import "CPCrowdViewController.h"
#import "CPAreaViewController.h"
#import "CPSlideView.h"

#define kWindowWidth            self.view.frame.size.width
#define kWindowHeight           self.view.frame.size.height

@interface ClassificationViewController ()

@end

@implementation ClassificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CPThemeViewController *theme = [[CPThemeViewController alloc] init];
    CPCrowdViewController *crowd = [[CPCrowdViewController alloc] init];
    CPAreaViewController *area = [[CPAreaViewController alloc] init];
    NSArray *slideArray = @[@{@"题材" : area}, @{@"人群" : crowd}, @{@"区域" : theme}];
    CPSlideView *slideView = [[CPSlideView alloc] initWithFrame:CGRectMake(0, 64,kWindowWidth, kWindowHeight) WithViewControllers:slideArray];
    
    [self.view addSubview:slideView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
