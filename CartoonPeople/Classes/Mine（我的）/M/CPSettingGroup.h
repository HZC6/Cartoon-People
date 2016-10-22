//
//  CPSettingGroup.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPSettingGroup : NSObject

/** 头标题 */
@property (nonatomic, copy) NSString *headerTitle;
/** 尾标题 */
@property (nonatomic, copy) NSString *footTitle;

/** 行模型数组 */
@property (nonatomic, strong) NSArray *items;

+ (instancetype)groupWithItems:(NSArray *)items;


@end
