//
//  CPGameHotCell.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPGameHotCell.h"
#import "CPhotClubItem.h"
#import <UIImageView+WebCache.h>

@interface CPGameHotCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *addNum;
@property (weak, nonatomic) IBOutlet UILabel *numlabel;

@end

@implementation CPGameHotCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setItem:(CPhotClubItem *)item {
    
    _item = item;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:item.icon] placeholderImage:[UIImage imageNamed:@"默认头像2"]];
    self.name.text = item.name;
    self.numlabel.text = item.messageNum;
    self.addNum.text = item.intro;
}

@end
