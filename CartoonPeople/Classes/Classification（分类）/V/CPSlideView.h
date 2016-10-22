//
//  CPSlideView.h
//  09_page
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPSlideView : UIView

@property (nonatomic,strong)NSArray * vcArray;

- (instancetype)initWithFrame:(CGRect)frame WithViewControllers:(NSArray *)viewControllers;

@end
