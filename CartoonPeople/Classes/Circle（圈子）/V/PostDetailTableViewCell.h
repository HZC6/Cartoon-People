//
//  PostDetailTableViewCell.h
//  CartoonPeople
//
//  Created by mac1 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class postDetailCellModel;
@interface PostDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)postDetailCellModel *model;
@property(nonatomic,strong)NSMutableArray *imagArr;

@end
