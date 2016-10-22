//
//  CAViewCell.h
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectModel.h"
@interface CAViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageViewURL;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**模型 **/
@property(nonatomic,strong)SubjectModel *model;
@end
