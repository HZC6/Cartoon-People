//
//  CAViewCell.m
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CAViewCell.h"

@implementation CAViewCell

- (void)awakeFromNib {
}

- (void)setModel:(SubjectModel *)model{
    _model = model;
    [_imageViewURL sd_setImageWithURL:[NSURL URLWithString:model.subcategoryImgUrl]];
    _nameLabel.text = model.subcategoryName;
}

@end
