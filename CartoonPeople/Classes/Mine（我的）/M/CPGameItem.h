//
//  CPGameItem.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPGameItem : NSObject

/** 图像 */
@property (nonatomic, copy) NSString *icon;
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 内容 */
@property (nonatomic, copy) NSString *intro;
/** 加入数 */
@property (nonatomic, copy) NSString *joinNum;
/** tag标签 */
@property (nonatomic, strong) NSArray *tag;
/** hot 1 new 2 */
@property (nonatomic, copy) NSString *label;

@end
