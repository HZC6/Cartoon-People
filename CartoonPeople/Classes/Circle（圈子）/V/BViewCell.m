//
//  BViewCell.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "BViewCell.h"
#import "ScroCollectionView1.h"
#import "ScroCollectionView2.h"

#import "PopView.h"
@interface BViewCell ()<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
}
@property (weak, nonatomic) IBOutlet UIButton *adBtn;
@property (weak, nonatomic) IBOutlet UIButton *serialBtn;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIView *scontentView;
@property (weak, nonatomic) IBOutlet UILabel *updateLabel;
@property (weak, nonatomic) IBOutlet UIView *lightView;


//增加的属性
@property(nonatomic,strong)UIView *shadowView;
@property(nonatomic,strong)UIView *openMoreView;

@end
@implementation BViewCell

- (void)awakeFromNib {
    
    self.lightView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    
    //创建滚动视图
   scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 156)];
    scrollView.delegate = self;

    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [self.scontentView addSubview:scrollView];
    
    ScroCollectionView1 *sroV1 = [[ScroCollectionView1 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ScroCollectionView2 *srocV2 = [[ScroCollectionView2 alloc]initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, kScreenHeight)];
    [scrollView addSubview:sroV1];
    [scrollView addSubview:srocV2];
    
 
}


#pragma mark -
#pragma mark - 隐藏下弹窗
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    _shadowView.hidden = YES;
}

//广告按钮
- (IBAction)adBtnAction:(UIButton *)sender {
    
    
}

//连载
- (IBAction)serialBtnAction:(UIButton *)sender {
    
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

//番外
- (IBAction)otherBtnAction:(UIButton *)sender {
    
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.serialBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [scrollView setContentOffset:CGPointMake(scrollView.frame.size.width, 0) animated:YES];
}
- (IBAction)openMore:(id)sender {
    

    [UIView animateWithDuration:0.25 animations:^{
        self.shadowView.hidden = NO;
    }];

    

}

-(UIView *)shadowView{
    
    if (_shadowView == nil) {
        
        _shadowView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _shadowView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.2];
        _shadowView.hidden = YES;
        [self.window addSubview:_shadowView];
        
        _openMoreView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreen_Height-300, kScreen_Width, 300)];
        _openMoreView.backgroundColor = [UIColor whiteColor];
        [_shadowView addSubview:_openMoreView];
        
        UIView *popV = [[[NSBundle mainBundle]loadNibNamed:@"PopView" owner:nil options:nil]lastObject];
        [_openMoreView addSubview:popV];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [_shadowView addGestureRecognizer:tap];
    }
    
    return _shadowView;
}

#pragma mark -
#pragma mark - 滑动视图的代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (scrollView.contentOffset.x < kScreenWidth) {

        [self.serialBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.otherBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }else{
        
        [self.serialBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.otherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}



@end
