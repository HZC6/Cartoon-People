//
//  YinYnagZModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//动漫简介
@interface YinYnagZModel : NSObject
//动漫的名字
@property(nonatomic,copy)NSString *mangaName;
//动漫作者
@property(nonatomic,copy)NSString *mangaAuthor;
//评分
@property(nonatomic,copy)NSString *mangaGrade;
//动漫介绍
@property(nonatomic,copy)NSString *mangaIntro;
//最新章节的名字
@property(nonatomic,copy)NSString *mangaNewsectionName;
//动漫类型
@property(nonatomic,copy)NSString *mangaTheme;
//章节
@property(nonatomic,strong)NSArray *mangaWords;
//番外
@property(nonatomic,strong)NSArray *mangaEpisode;


//自己增加的属性
@property(nonatomic,assign)CGFloat textViewHeight;

@end
