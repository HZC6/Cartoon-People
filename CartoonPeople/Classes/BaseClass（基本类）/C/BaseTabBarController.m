//
//  BaseTabBarController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "CircleViewController.h"
#import "BookcaseViewController.h"
#import "MineViewController.h"
#import "UIImage+Image.h"

#define KSCreenW [UIScreen mainScreen].bounds.size.width

@interface BaseTabBarController ()

@property(nonatomic,weak)UIImageView *selectImageV;
@property(nonatomic,strong)UIButton *lastButton;

@end

@implementation BaseTabBarController

//只会调用一次
+(void)load{
    
    //获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //设置按钮选中标题的颜色：富文本：描述一个文字颜色，字体，阴影，空心，图文混排
    //创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor yellowColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    //设置字体尺寸：只有设置正常状态下，才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrsNor[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置子控制器
    [self setupChildeVc];
    
    //设置标签栏上的内容
    [self setupAllButtonContent];
    
    //设置标签栏上的背景图片
   // self.tabBar.backgroundImage = [UIImage imageNamed:@"tab_all"];
    
    
}

#pragma mark -
#pragma mark - 创建标签控制器上的自控制器
- (void)setupChildeVc{
    

    UIStoryboard *homeStoryboard = [UIStoryboard storyboardWithName:@"HomeStoryboard" bundle:nil];
    UIStoryboard *classificationStoryboard = [UIStoryboard storyboardWithName:@"ClassificationStoryboard" bundle:nil];
    UIStoryboard *circleStoryboard = [UIStoryboard storyboardWithName:@"CircleStoryboard" bundle:nil];
    UIStoryboard *bookcaseStoryboard = [UIStoryboard storyboardWithName:@" BookcaseStoryboard" bundle:nil];
    UIStoryboard *mineStoryboard = [UIStoryboard storyboardWithName:@"MineStoryboard" bundle:nil];
    
    BaseNavigationController *home = [homeStoryboard instantiateInitialViewController];
    BaseNavigationController *classFica = [classificationStoryboard instantiateInitialViewController];
    BaseNavigationController *circle = [circleStoryboard instantiateInitialViewController];
    BaseNavigationController *bookcase = [bookcaseStoryboard instantiateInitialViewController];
    BaseNavigationController *mine = [mineStoryboard instantiateInitialViewController];
    

    [self addChildViewController:home];
    [self addChildViewController:classFica];
    [self addChildViewController:circle];
    [self addChildViewController:bookcase];
    [self addChildViewController:mine];

}


#pragma mark -
#pragma mark - 设置tabbar上按钮的内容

- (void)setupAllButtonContent{
    
    NSArray *imagenameNormal = @[@"首页-未选中",@"分类-未选中",@"圈子-未选中",@"书架-未选中",@"我的-未选中"];
    NSArray *imagenameHight = @[@"首页-选中",@"分类-选中",@"圈子-选中",@"书架-选中",@"我的-选中"];
    NSArray *btnName = @[@"首页",@"分类",@"圈子",@"书架",@"我的"];
    
    BaseNavigationController *nav = self.viewControllers[0];
    nav.tabBarItem.image = [UIImage imageNamed:imagenameNormal[0]];
    nav.tabBarItem.title = btnName[0];
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imagenameHight[0]];
    
 
    
    BaseNavigationController *nav1 = self.viewControllers[1];
    nav1.tabBarItem.title = btnName[1];
    nav1.tabBarItem.image = [UIImage imageNamed:imagenameNormal[1]];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imagenameHight[1]];
    
    BaseNavigationController *nav2 = self.viewControllers[2];
    nav2.tabBarItem.title = btnName[2];
    nav2.tabBarItem.image = [UIImage imageNamed:imagenameNormal[2]];
    nav2.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imagenameHight[2]];
    
    BaseNavigationController *nav3 = self.viewControllers[3];
    nav3.tabBarItem.title = btnName[3];
    nav3.tabBarItem.image = [UIImage imageNamed:imagenameNormal[3]];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imagenameHight[3]];
    
    BaseNavigationController *nav4 = self.viewControllers[4];
    nav4.tabBarItem.title = btnName[4];
    nav4.tabBarItem.image = [UIImage imageNamed:imagenameNormal[4]];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:imagenameHight[4]];


}



@end
