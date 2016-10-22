//
//  CPhotGiftItem.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPhotGiftItem : NSObject

/** 头像 */
@property (nonatomic, copy) NSString *icon;
/** 名字 */
@property (nonatomic, copy) NSString *name;
/** 礼品名字 */
@property (nonatomic, copy) NSString *giftName;
/** 礼包内容 */
@property (nonatomic, copy) NSArray *giftContent;

@end
