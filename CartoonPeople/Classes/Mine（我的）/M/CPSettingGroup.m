//
//  CPSettingGroup.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPSettingGroup.h"

@implementation CPSettingGroup

+ (instancetype)groupWithItems:(NSArray *)items {
    CPSettingGroup *group = [[CPSettingGroup alloc] init];
    group.items = items;
    return group;
}


@end
