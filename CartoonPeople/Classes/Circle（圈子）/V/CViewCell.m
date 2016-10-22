//
//  CViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CViewCell.h"
#import "ScroCollectionView3.h"
@interface CViewCell ()
@property (weak, nonatomic) IBOutlet UIView *scontentView;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet UIImageView *img6;
@property (weak, nonatomic) IBOutlet UIView *tuoballView;
@property (weak, nonatomic) IBOutlet UILabel *readNumber;
@property (weak, nonatomic) IBOutlet UIView *shadeView;
@property (weak, nonatomic) IBOutlet UIView *imgContentView;


@end

@implementation CViewCell

- (void)awakeFromNib {
  
    self.tuoballView.layer.cornerRadius = 7;
    self.shadeView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    self.imgContentView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    
    ScroCollectionView3 *sv = [[ScroCollectionView3 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.contentView addSubview:sv];
    
}



@end
