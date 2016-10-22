//
//  PopView.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/12.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "PopView.h"
#import "ScroCollectionView4.h"
#import "ScroCollectionView2.h"

@interface PopView ()<UIScrollViewDelegate>{
    
    UIScrollView *scrollView;
    
}


@property (weak, nonatomic) IBOutlet UIButton *serialBtn;

@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIView *scontentView;


@end

@implementation PopView

- (void)awakeFromNib{
    
    
    //创建滚动视图
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
    scrollView.delegate = self;
    
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*2, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    [self.scontentView addSubview:scrollView];
    
    ScroCollectionView4 *sroV1 = [[ScroCollectionView4 alloc]initWithFrame:[UIScreen mainScreen].bounds];
    ScroCollectionView2 *srocV2 = [[ScroCollectionView2 alloc]initWithFrame:CGRectMake(kScreen_Width, 0, kScreen_Width, kScreenHeight)];
    [scrollView addSubview:sroV1];
    [scrollView addSubview:srocV2];
    
    
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
