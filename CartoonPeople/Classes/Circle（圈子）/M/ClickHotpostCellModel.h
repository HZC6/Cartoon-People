//
//  ClickHotpostCellModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClickHotpostCellModel : NSObject
//内容
@property(nonatomic,copy)NSString *content;
//含有作者的名字：userName  头像：avatar
@property(nonatomic,strong)NSDictionary *author;
//发布时间
@property(nonatomic,strong)NSString *postTime;
//点赞
@property(nonatomic,strong)NSNumber *likeTotal;


@end
