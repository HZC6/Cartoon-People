//
//  UIView+Frame.m
//  Budejie
//
//  Created by mac1 on 16/8/20.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

//高
- (void)setZc_height:(CGFloat)zc_height{
    
    CGRect rect = self.frame;
    rect.size.height = zc_height;
    self.frame = rect;
    
}

- (CGFloat)zc_height{
    
    return self.frame.size.height;
}

//宽
-(void)setZc_width:(CGFloat)zc_width{
    
    CGRect rect = self.frame;
    rect.size.width = zc_width;
    self.frame = rect;
}
- (CGFloat)zc_width{
    
    return self.frame.size.width;
}

//x
- (void)setZc_x:(CGFloat)zc_x{
    
    CGRect rect = self.frame;
    rect.origin.x = zc_x;
    self.frame = rect;
}
-(CGFloat)zc_x{
    
    return self.frame.origin.x;
}

//y
- (void)setZc_y:(CGFloat)zc_y{
    
    CGRect rect = self.frame;
    rect.origin.y = zc_y;
    self.frame = rect;
}
-(CGFloat)zc_y{
    
   return self.frame.origin.y;
}
//centerX
-(void)setZc_centerX:(CGFloat)zc_centerX{
    
    CGPoint point = self.center;
    point.x = zc_centerX;
    self.center = point;
}
- (CGFloat)zc_centerX{
    
    return self.center.x;
}

//centerY
-(void)setZc_centerY:(CGFloat)zc_centerY{
    
    CGPoint point = self.center;
    point.x = zc_centerY;
    self.center = point;
}
- (CGFloat)zc_centerY{
    
    return self.center.y;
}
@end
