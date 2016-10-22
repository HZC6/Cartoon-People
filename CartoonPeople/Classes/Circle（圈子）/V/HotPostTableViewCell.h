//
//  HotPostTableViewCell.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotPostCellModel;
@interface HotPostTableViewCell : UITableViewCell

@property(nonatomic,strong)HotPostCellModel *model;

@property(nonatomic,strong)NSMutableArray *imagArr;

@end
