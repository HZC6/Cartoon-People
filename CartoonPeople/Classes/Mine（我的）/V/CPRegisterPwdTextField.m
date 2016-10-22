//
//  CPRegisterPwdTextField.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPRegisterPwdTextField.h"

@implementation CPRegisterPwdTextField

- (void)awakeFromNib {
        
    UIButton *forgetBtn = [[UIButton alloc] init];
    forgetBtn.frame = CGRectMake(0, 0, 15, 15);
    [forgetBtn setImage:[UIImage imageNamed:@"眼睛_灰"] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.rightView = forgetBtn;
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

@end
