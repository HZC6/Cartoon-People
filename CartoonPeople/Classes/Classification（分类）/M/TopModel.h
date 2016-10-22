//
//  TopModel.h
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface TopModel : NSObject
/**漫画名字 **/
@property(nonatomic,copy)NSString *mangaName;
/**内容 **/
@property(nonatomic,copy)NSString *mangaIntro;
/**作者 **/
@property(nonatomic,copy)NSString *mangaAuthor;
/**最新一话 **/
@property(nonatomic,copy)NSString *mangaNewestContent;
/**图片的url **/
@property(nonatomic,copy)NSString *mangaCoverimageUrl;
/**评分 **/
@property(nonatomic,assign)CGFloat mangaScore;
/**排名 **/
@property(nonatomic,assign)NSInteger topNumber;
/**类型 **/
@property(nonatomic,assign)NSInteger mangaIsOver;

@end
