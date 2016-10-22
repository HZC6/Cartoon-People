//
//  CPPwdTextField.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPPwdTextField.h"

@implementation CPPwdTextField

- (void)awakeFromNib {
    
    self.font = [UIFont systemFontOfSize:15];
    self.placeholder = @"请输入密码";
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    // 设置左边的放大镜图标
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"密码-未选中"];
    // 图标居中
    searchIcon.contentMode = UIViewContentModeRedraw;
    self.leftView = searchIcon;
    self.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.frame = CGRectMake(0, 0, 100, 30);
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    self.rightView = forgetBtn;
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftView.originX = 3;
    
    self.leftView.width = 15;
    self.leftView.height = 15;

}



@end
