//
//  postDetailCellModel.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "postDetailCellModel.h"
#define kedgWidth 10 //边距
#define imgSpace 5 //图片间边距
#define kCellHeadHeight 60 //边距
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation postDetailCellModel

//懒加载--创建九个空的frame
-(NSMutableArray *)imageFrameArr{
    if (_imageFrameArr == nil) {
        
        _imageFrameArr = [NSMutableArray array];
        
        for (int i=0; i<9; i++) {
            [_imageFrameArr addObject:[NSValue valueWithCGRect:CGRectZero]];
        }
        
    }
    
    return _imageFrameArr;
}

-(CGFloat)cellHeight{
    
    //多张正文图片
    //图片的大小
    CGFloat imgSize = (kScreenWidth - 2*kedgWidth-2*imgSpace)/3;
    if (self.pictures) {
        
        for (int i=0; i<self.pictures.count; i++) {
            //行和列
            int row = i/3;
            int culom = i%3;
            //第一张位置
            CGFloat imgeX = 8;
            CGFloat imgeY = 85+kedgWidth;
            CGRect imgFrame = CGRectMake(imgeX+culom*(imgSize+imgSpace), imgeY+row*(imgSize+imgSpace), imgSize, imgSize);
            
            //替换frame
            [self.imageFrameArr replaceObjectAtIndex:i  withObject:[NSValue valueWithCGRect:imgFrame]];
        }
        
        //单元格的高度
        /*
         1.图片的行数 0-3
         2.图片与图片之间的间距 0-2
         3.图片与正文之间的间距 0-1
         
         */
        NSInteger line = (self.pictures.count +2)/3;
        CGFloat imgHeight = line *imgSize + imgSpace *MAX(0, line-1) + kedgWidth *MIN(line, 1);
        
        _cellHeight = imgHeight+20+30+85;
        
        
    }
    return _cellHeight;
}


@end
