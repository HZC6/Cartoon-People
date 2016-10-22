//
//  MyTableViewCell.m
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TopModel *)model{
    _model = model;
   
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.mangaCoverimageUrl]];
    
    _NameLabel.text = model.mangaName;
    
    _myTextLabel.text = model.mangaIntro;
    
    _updataLabel.text = [NSString stringWithFormat:@"更新至%@",model.mangaNewestContent];
    _gradeLabel.text = [NSString stringWithFormat:@"%.1f", model.mangaScore];
    
    _gradeLabel.layer.cornerRadius = 5;
    _gradeLabel.layer.masksToBounds = YES;
    [_TopNumber setTitle:[NSString stringWithFormat:@"%ld",model.topNumber] forState:UIControlStateNormal];
    
    if (model.topNumber == 2) {
        [_TopNumber setBackgroundImage:[UIImage imageNamed:@"ph_2"] forState:UIControlStateNormal];
    }else if (model.topNumber == 3){
        [_TopNumber setBackgroundImage:[UIImage imageNamed:@"ph_3"] forState:UIControlStateNormal];
    }else if (model.topNumber > 3){
        [_TopNumber setBackgroundImage:[UIImage imageNamed:@"ph_4"] forState:UIControlStateNormal];
    }
    
    
    if (model.mangaScore == 0.0) {
        _gradeLabel.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
