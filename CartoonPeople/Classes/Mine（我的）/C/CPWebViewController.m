//
//  CPWebViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPWebViewController.h"

@interface CPWebViewController ()

@end

@implementation CPWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"福音战士" ofType:@"html"];
    
    // 根据路径取得文件内容
    NSString *content1 = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [webView loadHTMLString:content1 baseURL:nil];
    
    // 自适应屏幕
    [webView scalesPageToFit];
    
    [self.view addSubview:webView];

    self.title = @"新世纪福音战士OL";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
