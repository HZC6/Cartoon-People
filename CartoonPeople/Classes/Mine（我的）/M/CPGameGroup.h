//
//  CPGameGroup.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPGameGroup : NSObject

/** 头标题 */
@property (nonatomic, copy) NSString *theme;
/** 类型 */
@property (nonatomic, assign) int type;
/** 安装cell模型 */
@property (nonatomic, strong) NSArray *gameItems;
/** 礼包cell模型 */
@property (nonatomic, strong) NSArray *hotGiftItems;
/** 圈子cell模型 */
@property (nonatomic, strong) NSArray *hotClubItems;

+ (instancetype)groupWithGameItems:(NSArray *)items;
+ (instancetype)groupWithHotGiftItems:(NSArray *)items;
+ (instancetype)groupWithHotClubItems:(NSArray *)items;

@end
