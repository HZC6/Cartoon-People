//
//  ImagVCollectionViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/12.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ImagVCollectionViewCell.h"
#import "recommendedModel.h"
#import <UIImageView+WebCache.h>
@interface ImagVCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imagV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ImagVCollectionViewCell

- (void)awakeFromNib {
   
}
/*
 //漫画名字
 @property(nonatomic,copy)NSString *mangaName;
 //图片链接
 @property(nonatomic,copy)NSString *mangaCoverimageUrl;
 */
-(void)setModel:(recommendedModel *)model{
    
    _model = model;
    
    [self.imagV sd_setImageWithURL:[NSURL URLWithString:_model.mangaCoverimageUrl] placeholderImage:[UIImage imageNamed:@"默认图片"]];
    self.nameLabel.text = _model.mangaName;
    
    
}

@end
