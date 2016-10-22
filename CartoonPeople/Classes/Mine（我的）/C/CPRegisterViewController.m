//
//  CPRegisterViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPRegisterViewController.h"

@interface CPRegisterViewController ()

@end

@implementation CPRegisterViewController

static CPRegisterViewController *registerViewController = nil;

+ (instancetype)shareLoginViewController {
    
    @synchronized(self) {
        if (registerViewController == nil) {
            registerViewController = [[self alloc] init];
        }
    }
    return registerViewController;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (registerViewController == nil) {
        registerViewController = [super allocWithZone:zone];
    }
    return registerViewController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)backClick:(id)sender {
        
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end
