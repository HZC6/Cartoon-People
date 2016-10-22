//
//  CPGameBagCell.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPGameBagCell.h"
#import "CPhotGiftItem.h"
#import <UIImageView+WebCache.h>

@interface CPGameBagCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation CPGameBagCell

- (void)awakeFromNib {
    
    
}

- (void)setItem:(CPhotGiftItem *)item {
    
    _item = item;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"默认头像2"]];
    self.name.text = item.name;
    self.centerLabel.text = item.giftName;
    self.bottomLabel.text = item.giftContent[0];
    
}

@end
