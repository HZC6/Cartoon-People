//
//  HotCirecleCellModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotCirecleCellModel : NSObject

//名字
@property(nonatomic,copy)NSString *name;
//图片
@property(nonatomic,copy)NSString *cover;
//订阅
@property(nonatomic,copy)NSString *vitalityString;
//热评
@property(nonatomic,copy)NSString *lastPostContent;
//会员
@property(nonatomic,strong)NSNumber *totalMembers;
//转发量
@property(nonatomic,copy)NSNumber *totalPosts;

@end
