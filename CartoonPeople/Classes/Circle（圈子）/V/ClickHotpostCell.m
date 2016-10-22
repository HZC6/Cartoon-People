//
//  ClickHotpostCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ClickHotpostCell.h"
#import "ClickHotpostCellModel.h"
#import <UIImageView+WebCache.h>
@interface ClickHotpostCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ClickHotpostCell

- (void)awakeFromNib {
    
}

-(void)setModel:(ClickHotpostCellModel *)model{
    
    _model = model;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    /*
     //内容
     @property(nonatomic,copy)NSString *content;
     //含有作者的名字：userName  头像：avatar
     @property(nonatomic,strong)NSDictionary *author;
     //发布时间
     @property(nonatomic,strong)NSString *postTime;
     //点赞
     @property(nonatomic,strong)NSNumber *likeTotal;
     
     */
    
    //用户名字
    self.userName.text = _model.author[@"userName"];
    //用户头像
    if ([_model.author[@"avatar"] isKindOfClass:[NSString class]]&&[_model.author[@"avatar"] containsString:@"jpg"]) {
        
        
        [self.userImg sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: _model.author[@"avatar"] ]placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            //1.开启上下文
            //比例因素：当前点与像素比例
            UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
            //2 描述裁剪区域
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
            //3 设置裁剪区域
            [path addClip];
            //4 画图片
            [image drawAtPoint:CGPointZero];
            //5 取出图片
            image = UIGraphicsGetImageFromCurrentImageContext();
            //6 关闭上下文
            UIGraphicsEndImageContext();
            self.userImg.image = image;
            
        }];
    }
    
    //日期
    self.dateLabel.text = _model.postTime;
    //评论内容
    self.contentLabel.text = _model.content;
    //点赞数
    self.zanNumberLabel.text = [_model.likeTotal stringValue];
}

- (IBAction)zanBtnAction:(UIButton *)sender {
    
    
}


@end
