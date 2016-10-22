//
//  CPGameGroup.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPGameGroup.h"

@implementation CPGameGroup

+ (instancetype)groupWithGameItems:(NSArray *)items {
    
    CPGameGroup *group = [[CPGameGroup alloc] init];
    group.gameItems = items;
    return group;
}

+ (instancetype)groupWithHotGiftItems:(NSArray *)items {
    CPGameGroup *group = [[CPGameGroup alloc] init];
    group.hotGiftItems = items;
    return group;
}

+ (instancetype)groupWithHotClubItems:(NSArray *)items {
    CPGameGroup *group = [[CPGameGroup alloc] init];
    group.hotClubItems = items;
    return group;
}

@end
