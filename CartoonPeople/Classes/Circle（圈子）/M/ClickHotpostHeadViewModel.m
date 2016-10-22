//
//  ClickHotpostHeadViewModel.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/9.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ClickHotpostHeadViewModel.h"
#define margin 10
#define topHeight 60
#define bottomHeight 80
@implementation ClickHotpostHeadViewModel

-(CGFloat)cellHeight{
    
    //上半部分的高度
    CGFloat cellHeight = topHeight;
    //计算说说内容的高度
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    CGRect rect =  [self.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-8, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    cellHeight = cellHeight + rect.size.height;
    //计算图片frame
    for (int i=0; i<self.pictures.count; i++) {
        
        CGFloat x = 5;
        CGFloat y = 500*i+margin+cellHeight;
        
        NSInteger n = 0;
        if ( n != 0) {
            n = 1;
        }
        CGRect frame = CGRectMake(x, y+margin*i, [UIScreen mainScreen].bounds.size.width-10, 500);
        [self.imgArrayFrame addObject:[NSValue valueWithCGRect:frame]];
    }
    
    cellHeight = cellHeight + self.pictures.count*(500+margin)+bottomHeight;
    
    _cellHeight = cellHeight;
    
    
    return _cellHeight;
}

-(NSMutableArray *)imgArrayFrame{
    if (_imgArrayFrame == nil) {
        _imgArrayFrame = [[NSMutableArray alloc]init];
    }
    
    return _imgArrayFrame;
}

@end
