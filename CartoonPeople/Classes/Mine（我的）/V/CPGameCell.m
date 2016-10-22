//
//  CPGameCell.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPGameCell.h"
#import "CPGameItem.h"
#import <UIImageView+WebCache.h>

@interface CPGameCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *tag1;
@property (weak, nonatomic) IBOutlet UILabel *tag2;
@property (weak, nonatomic) IBOutlet UILabel *tag3;
@property (weak, nonatomic) IBOutlet UILabel *addNum;


@end

@implementation CPGameCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(CPGameItem *)item {
    
    _item = item;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"默认图片2"]];
    self.name.text = item.name;
    self.content.text = item.intro;
    self.tag1.text = item.tag[0];
    self.tag2.text = item.tag[1];
    self.tag3.text = item.tag[2];
    self.addNum.text = item.joinNum;
    self.label.text = item.label;
}

@end
