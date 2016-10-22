//
//  CPSettingItem.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPSettingItem.h"

@implementation CPSettingItem

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title {
    CPSettingItem *item = [[CPSettingItem alloc] init];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle {
    CPSettingItem *item = [[CPSettingItem alloc] init];
    item.icon = icon;
    item.title = title;
    item.subTitle = subTitle;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title {
    return [self itemWithIcon:nil title:title];
}

@end
