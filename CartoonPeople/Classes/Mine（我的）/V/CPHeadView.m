//
//  CPHeadView.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPHeadView.h"
#import "CPLoginViewController.h"
#import "CPRegisterViewController.h"
#import "CPSettingViewController.h"

@interface CPHeadView ()

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation CPHeadView

- (void)awakeFromNib {
    self.registerBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.registerBtn.layer.borderWidth = 1;
    [self.registerBtn addTarget:self action:@selector(registerBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    self.loginBtn.layer.borderWidth = 1;
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
}

+ (instancetype)headView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:self options:nil].lastObject;
}

- (void)loginBtnClick {
    
    CPLoginViewController *loginVc = [[CPLoginViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[4]pushViewController:loginVc animated:YES];
    
}

- (void)registerBtnClick {
    
    CPRegisterViewController *registerVc = [[CPRegisterViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[4] pushViewController:registerVc animated:YES];
}

- (IBAction)settingClick:(id)sender {
    
    CPSettingViewController *settingVc = [[CPSettingViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[4] pushViewController:settingVc animated:YES];
}


@end
