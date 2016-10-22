//
//  TypeViewController.h
//  CartoonPeople
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TypeViewController : UIViewController
/**模型数组 **/
@property(nonatomic,strong)NSMutableArray *dataArray;
/**类型 **/
@property(nonatomic,copy)NSString *type;
@end
