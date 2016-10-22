//
//  CPTextField.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPTextField.h"

@implementation CPTextField

- (void)awakeFromNib {
    
    self.font = [UIFont systemFontOfSize:15];
    self.placeholder = @"请输入用户名、邮箱";
    self.clearButtonMode = UITextFieldViewModeAlways;
    self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
    
    // 设置左边的放大镜图标
    UIImageView *searchIcon = [[UIImageView alloc] init];
    searchIcon.image = [UIImage imageNamed:@"用户名-未选中"];
    // 图标居中
    searchIcon.contentMode = UIViewContentModeRedraw;
    self.leftView = searchIcon;
    self.leftViewMode = UITextFieldViewModeAlways;

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.leftView.originX = 3;
    self.leftView.width = 15;
    self.leftView.height = 15;
    
}

@end
