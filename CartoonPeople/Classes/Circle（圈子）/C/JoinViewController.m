//
//  JoinViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "JoinViewController.h"
#import "CPLoginViewController.h"

@interface JoinViewController ()

@end

@implementation JoinViewController
- (IBAction)siginBtnAction:(UIButton *)sender {
    
    CPLoginViewController *loginVc = [[CPLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
}


@end
