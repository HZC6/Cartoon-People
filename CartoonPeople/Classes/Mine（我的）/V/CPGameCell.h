//
//  CPGameCell.h
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CPGameItem;

@interface CPGameCell : UITableViewCell

/** game模型 */
@property (nonatomic, strong) CPGameItem *item;

@end
