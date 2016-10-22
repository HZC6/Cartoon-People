//
//  CPhotClubItem.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPhotClubItem : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *icon;
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 消息数 */
@property (nonatomic, copy) NSString *messageNum;
/** 加入人数 */
@property (nonatomic, copy) NSString *intro;

@end
