//
//  MyTableViewCell.h
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *TopNumber;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *myTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *updataLabel;

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;


/**模型 **/
@property(nonatomic,strong)TopModel *model;

@end
