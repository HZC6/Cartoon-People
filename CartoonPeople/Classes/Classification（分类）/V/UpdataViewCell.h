//
//  UpdataViewCell.h
//  CartoonPeople
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"
@interface UpdataViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *typeImage;
@property (weak, nonatomic) IBOutlet UILabel *updataLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**模型 **/
@property(nonatomic,strong)TopModel *model;

@end
