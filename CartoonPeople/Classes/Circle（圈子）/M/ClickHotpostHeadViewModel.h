//
//  ClickHotpostHeadViewModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//热门帖子点击后的说说和图片
@interface ClickHotpostHeadViewModel : NSObject
//说说内容
@property(nonatomic,copy)NSString *content;
//名字：userName  头像：avatar
@property(nonatomic,strong)NSDictionary *author;
//时间
@property(nonatomic,copy)NSString *postTime;
//说说图片组(存储的是字典对象 urlOrigin)
@property(nonatomic,strong)NSArray *pictures;
//点赞量
@property(nonatomic,strong)NSNumber *likeTotal;
//喜欢者(里面存储的是字典对象 头像：avatar  用户名：userName)
@property(nonatomic,strong)NSArray *likers;


//自定义的属性
@property(nonatomic,assign)CGFloat cellHeight;
//图片frame数组
@property(nonatomic,strong)NSMutableArray *imgArrayFrame;



@end
