//
//  CPMineCell.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPMineCell.h"
#import "CPSettingGroup.h"
#import "CPSettingItem.h"
#import "UIView+Extension.h"

@implementation CPMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.textLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        self.detailTextLabel.textColor = [UIColor colorWithRed:101/255.0 green:101/255.0 blue:101/255.0 alpha:1];
    }
    
    return self;
}

- (void)setItem:(CPSettingItem *)item {
    _item = item;
    self.imageView.image = item.icon;
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subTitle;
    
    if ((item.type == CPSettingItemRightViewStateAllow) | (item.type == CPSettingItemRightViewStateSubTitle) | (item.type == CPSettingItemRightViewStateImage)) {
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jt"]];
        
    } else if (item.type == CPSettingItemRightViewStateSwitch) {
        
        UISwitch *sw = [[UISwitch alloc] init];
        sw.on = item.isOn;
        self.accessoryView = sw;
        
    } else {
        self.accessoryView = nil;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.item.type == CPSettingItemRightViewStateSubTitle) {
        self.imageView.width = 60;
        self.imageView.height = self.imageView.width;
        self.imageView.centerY = self.contentView.height * 0.5;
        self.accessoryView.width = 7;
        self.accessoryView.height = 15;
        self.accessoryView.x = kScreenWidth - 18;
        self.accessoryView.centerY = self.contentView.height * 0.5;
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
        self.detailTextLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
        
    } else if(self.item.type == CPSettingItemRightViewStateSwitch) {
    
        self.accessoryView.width = 10;
        self.accessoryView.height = 15;
        self.accessoryView.centerY = self.contentView.height * 0.5;
        
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;

    
    } else if(self.item.type == CPSettingItemRightViewStateImage) {
        
        self.imageView.width = 20;
        self.imageView.height = self.imageView.width;
        self.imageView.centerY = self.contentView.height * 0.5;
        self.accessoryView.width = 7;
        self.accessoryView.height = 15;
        self.accessoryView.x = kScreenWidth - 18;
        self.accessoryView.centerY = self.contentView.height * 0.5;
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
        self.detailTextLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;
        
    } else {
        
        self.accessoryView.width = 7;
        self.accessoryView.height = 15;
        self.accessoryView.centerY = self.contentView.height * 0.5;
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + 10;

    }
}


@end
