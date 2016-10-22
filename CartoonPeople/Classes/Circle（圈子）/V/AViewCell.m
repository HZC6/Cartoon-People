//
//  AViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "AViewCell.h"
#import "YinYnagZModel.h"
#import "UIView+Frame.h"
@interface AViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UILabel *critingLabel;
@property (weak, nonatomic) IBOutlet UIButton *readBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation AViewCell

- (void)awakeFromNib {
    // Initialization code
}
/*
 //动漫简介
 @interface YinYnagZModel : NSObject
 //动漫的名字
 @property(nonatomic,copy)NSString *mangaName;
 //动漫作者
 @property(nonatomic,copy)NSString *mangaAuthor;
 //评分
 @property(nonatomic,copy)NSString *mangaGrade;
 //动漫介绍
 @property(nonatomic,copy)NSString *mangaIntro;
 //最新章节的名字
 @property(nonatomic,copy)NSString *mangaNewsectionName;
 //动漫类型
 @property(nonatomic,copy)NSString *mangaTheme;
 //章节
 @property(nonatomic,strong)NSArray *mangaWords;
 //番外
 @property(nonatomic,strong)NSArray *mangaEpisode;
 
 */
-(void)setModel:(YinYnagZModel *)model{
    
    _model = model;
    
    self.nameLabel.text = _model.mangaName;
    self.classLabel.text = [NSString stringWithFormat:@"类型:%@",_model.mangaTheme];
    self.authorLabel.text = [NSString stringWithFormat:@"作者:%@",_model.mangaAuthor];
    self.updateLabel.text = _model.mangaNewsectionName;
    self.critingLabel.text = _model.mangaGrade;
    self.textView.text = _model.mangaIntro;
    
    
}

//设置约束
- (void)layoutSubviews{
    

    self.textView.zc_height = _model.textViewHeight;

}

- (IBAction)readBtnAction:(UIButton *)sender {
    
    
    
}

- (IBAction)collectionBtnAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
}
- (IBAction)openTextViewAction:(UIButton *)sender {
    
    
}

@end
