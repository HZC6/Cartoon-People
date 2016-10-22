//
//  ScrollTableViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ScrollTableViewCell.h"
#import "scrollConmentModel.h"
#import <UIImageView+WebCache.h>
@interface ScrollTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zanNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ScrollTableViewCell

- (void)awakeFromNib {
    
}

-(void)setModel:(scrollConmentModel *)model{
    
    _model = model;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //用户名字
    self.userName.text = _model.userName;
    //用户头像
    if ([_model.userHeadimageUrl isKindOfClass:[NSString class]]&&[_model.userHeadimageUrl containsString:@"png"]) {
        
        
        [self.userImg sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: _model.userHeadimageUrl ]placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
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
    self.dateLabel.text = _model.commentTime;
    //评论内容
    self.contentLabel.text = _model.commentContent;
    //点赞数
    self.zanNumberLabel.text = [_model.commentHots stringValue];
}

#warning 循环后，数字的bug
- (IBAction)zanBtnAction:(UIButton *)sender {
    
    static  NSInteger i = 0;
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
       i = [_model.commentHots integerValue];
        i += 1;

        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",i];
    }else{
        
        i -= 1;
        self.zanNumberLabel.text = [NSString stringWithFormat:@"%ld",i];
    }
    
}




@end
