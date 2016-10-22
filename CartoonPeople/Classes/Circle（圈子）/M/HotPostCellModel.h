//
//  HotPostCellModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HotPostCellModel : NSObject

//资源区含有专区的名字（name）
@property(nonatomic,strong)NSDictionary *source;
//图片数组（中第一个数组：缩略图：url140  正常图：urlOrigin）
@property(nonatomic,strong)NSArray *pictures;
//喜欢人数
@property(nonatomic,strong)NSNumber *likeTotal;
//回复人数
@property(nonatomic,strong)NSNumber *replyTotal;
//是否是热门
@property(nonatomic,strong)NSNumber *isHot;
//时间
@property(nonatomic,strong)NSString *activateTime;
//内容
@property(nonatomic,strong)NSString *content;
//作者具体内容(用户名：userName，用户头像：avatar)
@property(nonatomic,strong)NSDictionary *author;



//增加属性（用来计算cell的高度和内容图片的布局）
@property(nonatomic,assign)CGFloat cellHeight;
@property(nonatomic,strong)NSMutableArray *imageFrameArr;








@end
