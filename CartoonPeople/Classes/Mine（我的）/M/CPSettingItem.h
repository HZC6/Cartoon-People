//
//  CPSettingItem.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    CPSettingItemRightViewStateNone,
    CPSettingItemRightViewStateAllow,
    CPSettingItemRightViewStateImage,
    CPSettingItemRightViewStateSwitch,
    CPSettingItemRightViewStateSubTitle
} CPSettingItemRightViewState;

@interface CPSettingItem : NSObject

/** 图片 */
@property (nonatomic, strong) UIImage *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subTitle;
/** 状态 */
@property (nonatomic, assign) CPSettingItemRightViewState type;
/** 目标控制器 */
@property (nonatomic, assign) Class desVc;
/** 点击要做的事情 */
@property (nonatomic, copy) void (^operationBlock)();

/** 开关状态 */
@property (nonatomic, assign, getter=isOn) BOOL on;

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title;

+ (instancetype)itemWithIcon:(UIImage *)icon title:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithTitle:(NSString *)title;


@end
