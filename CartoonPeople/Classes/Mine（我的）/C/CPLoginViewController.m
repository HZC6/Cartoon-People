//
//  CPLoginViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPLoginViewController.h"
#import "CPRegisterViewController.h"

@interface CPLoginViewController ()



@end

@implementation CPLoginViewController

static CPLoginViewController *loginViewController = nil;

+ (instancetype)shareLoginViewController {
    
    @synchronized(self) {
        if (loginViewController == nil) {
            loginViewController = [[self alloc] init];
        }
    }
    return loginViewController;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (loginViewController == nil) {
        loginViewController = [super allocWithZone:zone];
    }
    return loginViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)registerClick:(id)sender {
    
    CPRegisterViewController *registerVc = [[CPRegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
    
}

- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
