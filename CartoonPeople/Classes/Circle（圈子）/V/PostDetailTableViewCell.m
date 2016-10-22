//
//  PostDetailTableViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "PostDetailTableViewCell.h"
#import "postDetailCellModel.h"
#import <UIImageView+WebCache.h>
#import "WXPhotoBrowser.h"
#import "UIView+Frame.h"

@interface PostDetailTableViewCell ()<PhotoBrowerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userImgV;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *zoneLabel;
@property (weak, nonatomic) IBOutlet UIImageView *hotImgV;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;

@end

@implementation PostDetailTableViewCell

- (void)awakeFromNib {
    
    self.btn1.layer.cornerRadius = 7;
    self.btn1.layer.borderWidth = 1;
    self.btn1.layer.borderColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5].CGColor;
    self.btn2.layer.cornerRadius = 7;
    self.btn2.layer.borderWidth = 1;
    self.btn2.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    
}

-(void)setModel:(postDetailCellModel *)model{
    
    _model = model;
    
    [self setNeedsLayout];
}
#pragma mark -
#pragma mark -设置内容视图
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    //设置专区的名字
    self.zoneLabel.text = _model.source[@"name"];
    //设置点赞的人数
    self.praiseLabel.text = [_model.likeTotal stringValue];
    //设置评论人数
    self.commentsLabel.text = [_model.replyTotal stringValue];
    //设置是否显示热搜图片
    if([_model.isTop integerValue]){
        
        self.hotImgV.hidden = NO;
    }else{
        self.hotImgV.hidden = YES;
    }
    //设置时间
    self.timeLabel.text = _model.activateTime;
    //设置圆角头像
    if ([_model.author[@"avatar"] isKindOfClass:[NSString class]]) {
     
        
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

    //设置用户名
    self.userNameLabel.text = _model.author[@"userName"];
    //设置评论内容
    self.contentLabel.text = _model.content;
    
    //设置每个view的frame
    for (int i = 0; i<self.imagArr.count; i++) {
        UIImageView *imgV = self.imagArr[i];
        imgV.frame = [_model.imageFrameArr[i] CGRectValue];
        
    }
    
    //设置imgV上的图片
    for (int i=0; i<_model.pictures.count; i++) {
        
        //图片数组（中第一个数组：缩略图：url140  正常图：urlOrigin）
        // @property(nonatomic,strong)NSArray *pictures;
        //图片
        UIImageView *imgView = self.imagArr[i];
        
        
        
        NSString *str= _model.pictures[i][@"url140"];
        
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"默认图片（140X140）"]];
        
        
        
    }
}
#pragma mark -
#pragma mark -懒加载创建图片数组
-(NSMutableArray *)imagArr{
    
    if (_imagArr == nil) {
        
        _imagArr = [NSMutableArray array];
        
        for (int i=0; i<9; i++) {
            UIImageView *imgeV = [[UIImageView alloc]init];
            [self.contentView addSubview:imgeV];
            
            imgeV.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [imgeV addGestureRecognizer:tap];
            imgeV.tag = i;
            [_imagArr addObject:imgeV];
        }
    }
    
    return _imagArr;
    
}


#pragma mark -
#pragma mark - 手势点击的方法
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [WXPhotoBrowser showImageInView:self.window selectImageIndex:tap.view.tag delegate:self];
}

#pragma mark -
#pragma mark - PhotoBrowerDelegate
//需要显示的图片个数
- (NSUInteger)numberOfPhotosInPhotoBrowser:(WXPhotoBrowser *)photoBrowser{
    
    return _model.pictures.count;
}

//返回需要显示的图片对应的photo实例，通过photo类指定大图的url，以及原始的图片视图
- (WXPhoto *)photoBrowser:(WXPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    //图片的对象
    WXPhoto *photo = [[WXPhoto alloc]init];
    NSArray *urls = nil;
    
    if (_model.pictures.count > 0) {
        
        //获取创建的imgV
        photo.srcImageView = self.imagArr[index];
        
        //获取图片的链接数组
        urls = _model.pictures;
    }
    
    //缩略图
    NSString *imgUrl = urls[index][@"urlOrigin"];
    
    //转换成大图的url
    imgUrl = [imgUrl stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
    photo.url = [NSURL URLWithString:imgUrl];
    return photo;
    
    
}
-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= 10;
    
    [super setFrame:frame];
    
}



@end
