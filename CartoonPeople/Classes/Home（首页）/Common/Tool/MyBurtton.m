//
//  MyBurtton.m
//  按钮动画
//
//  Created by mac on 16/9/4.
//  Copyright © 2016年 LiuChao. All rights reserved.
//

#import "MyBurtton.h"
#define KSCreenW [UIScreen mainScreen].bounds.size.width
#define KSCreenH [UIScreen mainScreen].bounds.size.height
@interface MyBurtton()
{
}
@end
@implementation MyBurtton
- (void)createButton:(CGPoint)point tag:(NSInteger)tag View:(id)view{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(point.x, point.y, 40, 40)];
    btn.layer.cornerRadius = 20;
    [btn setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
    [btn setTitle:@"Top" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.tag = tag;
    [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
}




- (void)animationDirection:(NSString *)Direction Index:(int)index Number:(NSInteger)number Point:(CGPoint)point{
    CGFloat x = point.x;
    CGFloat y = point.y;
    if ([Direction isEqualToString:@"rightDown"]) {
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.keyPath = @"transform.scale";
        anima.toValue = @6;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *anima1 = [CABasicAnimation animation];
        anima1.keyPath = @"position";
        anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(x+90*cos(M_PI*index/(2*(number-1))),y+90*sin(M_PI*index/(2*(number-1))))];
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = @[anima,anima1];
        [self.layer addAnimation:group forKey:nil];
    }else if([Direction isEqualToString:@"rightUp"]){
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.keyPath = @"transform.scale";
        anima.toValue = @6;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *anima1 = [CABasicAnimation animation];
        anima1.keyPath = @"position";
        anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(x+90*cos(M_PI*index/(2*(number-1))),y-90*sin(M_PI*index/(2*(number-1))))];
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = @[anima,anima1];
        [self.layer addAnimation:group forKey:nil];
    
    }else if([Direction isEqualToString:@"leftDown"]){
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.keyPath = @"transform.scale";
        anima.toValue = @6;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *anima1 = [CABasicAnimation animation];
        anima1.keyPath = @"position";
        anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(x-90*cos(M_PI*index/(2*(number-1))),y+90*sin(M_PI*index/(2*(number-1))))];
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = @[anima,anima1];
        [self.layer addAnimation:group forKey:nil];
    }else if([Direction isEqualToString:@"leftUp"]){
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.keyPath = @"transform.scale";
        anima.toValue = @6;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *anima1 = [CABasicAnimation animation];
        anima1.keyPath = @"position";
        anima1.toValue = [NSValue valueWithCGPoint:CGPointMake(x-90*cos(M_PI*index/(2*(number-1))),y-90*sin(M_PI*index/(2*(number-1))))];
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = @[anima,anima1];
        [self.layer addAnimation:group forKey:nil];
    }else if ([Direction isEqualToString:@"back"]){
        CABasicAnimation *anima = [CABasicAnimation animation];
        anima.keyPath = @"transform.scale";
        anima.toValue = @1;
        CAAnimationGroup *group = [CAAnimationGroup animation];
        
        CABasicAnimation *anima1 = [CABasicAnimation animation];
        anima1.keyPath = @"position";
        anima1.toValue = [NSValue valueWithCGPoint:point];
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        group.animations = @[anima,anima1];
        [self.layer addAnimation:group forKey:nil];
    }
    

    
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    if (event.type != UIEventTypeTouches) {
        return [super pointInside:point withEvent:event];
    }
    CGRect testFrame = CGRectMake(-12.5, -12.5, 30, 30);
    return CGRectContainsPoint(testFrame, point);
}

@end
