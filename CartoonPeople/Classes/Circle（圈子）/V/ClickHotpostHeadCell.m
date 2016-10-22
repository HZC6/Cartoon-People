//
//  ClickHotpostHeadCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ClickHotpostHeadCell.h"
#import "ClickHotpostHeadViewModel.h"

@interface ClickHotpostHeadCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV1;
@property (weak, nonatomic) IBOutlet UIImageView *imgV2;
@property (weak, nonatomic) IBOutlet UIImageView *imgV3;
@property (weak, nonatomic) IBOutlet UIImageView *imgV4;
@property (weak, nonatomic) IBOutlet UIImageView *imgV5;
@property (weak, nonatomic) IBOutlet UIImageView *imgV6;
@property (weak, nonatomic) IBOutlet UIButton *gunZhuBtn;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@property (nonatomic,strong)NSMutableArray *imgArray;

@end
@implementation ClickHotpostHeadCell

-(NSMutableArray *)imgArray{
    if (_imgArray == nil) {
        _imgArray = [NSMutableArray array];
        
    }
    
    return _imgArray;
}

- (void)awakeFromNib {
    
    
}

-(void)setModel:(ClickHotpostHeadViewModel *)model{
    
    _model = model;
    
    [self setNeedsLayout];
    
    [self setupSubviews];
    
}

/*
 //说说内容
 @property(nonatomic,copy)NSString *content;
 //名字：userName  头像：avatar
 @property(nonatomic,strong)NSDictionary *author;
 //时间
 @property(nonatomic,copy)NSString *postTime;
 //说说图片组(存储的是字典对象 urlOrigin)
 @property(nonatomic,strong)NSArray *pictures;
 //点赞量
 @property(nonatomic,strong)NSNumber *likeTotal;
 //喜欢者(里面存储的是字典对象 头像：avatar  用户名：userName)
 @property(nonatomic,strong)NSArray *likers;
 

 
 */

- (void)setupSubviews{
    
    //用户名字
    self.userNameLabel.text = _model.author[@"userName"];
    //用户头像
    if ([_model.author[@"avatar"] isKindOfClass:[NSString class]]&&[_model.author[@"avatar"] containsString:@"jpg"]) {
        
        
        [self.userImgV sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: _model.author[@"avatar"] ]placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
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
            self.userImgV.image = image;
            
        }];
    }
    //设置时间
    self.dateLabel.text = _model.postTime;

    //创建图片并设置设置frame
    for (int i=0; i<_model.pictures.count; i++) {
        
        UIImageView *imgV = [[UIImageView alloc]init];
        [self.contentView addSubview:imgV];
        imgV.frame = [_model.imgArrayFrame[i] CGRectValue];
        
        [imgV sd_setImageWithURL:_model.pictures[i][@"urlOrigin"] placeholderImage:[UIImage imageNamed:@"默认图片"]];
        
    }
    
    //设置内容
    self.contentLabel.text = _model.content;
    
    //设置关注者的头像
    NSArray *imgVs = @[self.imgV1,self.imgV2,self.imgV3,self.imgV4,self.imgV5,self.imgV6];
    for (int i = 0; i<imgVs.count; i++) {
        
        UIImageView *imgv = imgVs[i];
        
        NSDictionary *dict = _model.likers[23+i];
        
    if ([dict[@"avatar"] isKindOfClass:[NSString class]]&&[dict[@"avatar"] containsString:@"jpg"]) {
        
        
        [imgv sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString: _model.author[@"avatar"] ]placeholderImage:[UIImage imageNamed:@"默认头像"] options:SDWebImageCacheMemoryOnly progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
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
            imgv.image = image;
            
        }];
    }
  }
   
    //喜欢的人数
    self.likeLabel.text = [_model.likeTotal stringValue];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
}



- (IBAction)guanZhuAction:(UIButton *)sender {
}
- (IBAction)likeBtnAction:(UIButton *)sender {
}


@end
