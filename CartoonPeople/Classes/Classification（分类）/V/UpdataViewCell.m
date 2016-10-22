//
//  UpdataViewCell.m
//  CartoonPeople
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "UpdataViewCell.h"

@implementation UpdataViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TopModel *)model{
    _model = model;
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.mangaCoverimageUrl]];
    _nameLabel.text = model.mangaName;
    _updataLabel.text = model.mangaNewestContent;
}
@end
