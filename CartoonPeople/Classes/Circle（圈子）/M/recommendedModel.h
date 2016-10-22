//
//  recommendedModel.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/10.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>
//滚动视图点击后的漫画推荐
@interface recommendedModel : NSObject
//漫画名字
@property(nonatomic,copy)NSString *mangaName;
//图片链接
@property(nonatomic,copy)NSString *mangaCoverimageUrl;

@end
