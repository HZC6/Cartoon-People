//
//  HotCircleTableViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "HotCircleTableViewCell.h"
#import "HotCirecleCellModel.h"
#import <UIImageView+WebCache.h>

@interface HotCircleTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *hotImageV;
@property (weak, nonatomic) IBOutlet UILabel *hotNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotJoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotPublishLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotComentLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotNumberLabel;


@end

@implementation HotCircleTableViewCell

- (void)awakeFromNib {
    
   
    
}

-(void)setModel:(HotCirecleCellModel *)model{
    _model = model;
    
    [self setupSubViews];
}

- (void)setupSubViews{
    
    [self.hotImageV sd_setImageWithURL:[NSURL URLWithString:_model.cover]placeholderImage:[UIImage imageNamed:@"默认图片（140X140）"]];
    self.hotNameLabel.text = _model.name;
    self.hotNumberLabel.text = _model.vitalityString;
    self.hotPublishLabel.text = [_model.totalPosts stringValue];
    self.hotJoinLabel.text = [_model.totalMembers stringValue];
    self.hotComentLabel.text = _model.lastPostContent;
    
}

@end
