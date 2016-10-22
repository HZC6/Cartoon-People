//
//  scrollConmentModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//滚动视图点击后的详细评论
@interface scrollConmentModel : NSObject
//用户头像
@property(nonatomic,copy)NSString *userHeadimageUrl;
//用户名字
@property(nonatomic,copy)NSString *userName;
//用户评论
@property(nonatomic,copy)NSString *commentContent;
//用户评论时间
@property(nonatomic,copy)NSString *commentTime;
//点赞数量
@property(nonatomic,copy)NSNumber *commentHots;
@end
