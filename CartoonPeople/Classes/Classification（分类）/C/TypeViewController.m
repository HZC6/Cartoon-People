//
//  TypeViewController.m
//  CartoonPeople
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "TypeViewController.h"
#import "TopModel.h"
#import <MJExtension.h>
#import "UpdataViewCell.h"
#import "CPSlideView.h"
#import "MyScrollViewController.h"
@interface TypeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation TypeViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self createView];
    self.navigationItem.title = _type;
}


- (void)loadData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"最近更新" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic2 = [NSDictionary dictionary];
    dic2 = dic1[@"response"];
    NSArray *array = [TopModel mj_objectArrayWithKeyValuesArray:dic2[@"mangas"]];
    
    for (int i = 0 ; i<array.count; i++) {
        [self.dataArray addObject:array[i]];
    }
}

#pragma mark - 创建集合视图
- (void)createView{
    UIViewController *plish = [[UIViewController alloc]init];
    UIViewController *cont = [[UIViewController alloc]init];
    UIViewController *hot = [[UIViewController alloc]init];
    UIViewController *new = [[UIViewController alloc]init];
    NSArray *slideArray = @[@{@"连载中" : cont}, @{@"已完结" : plish}, @{@"最热门" : hot}, @{@"最新发布" : new}];
    CPSlideView  *cp = [[CPSlideView alloc]initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight) WithViewControllers:slideArray];
    [self.view addSubview:cp];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake((kScreenWidth-40)/3, 150);
    
    UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    view.showsVerticalScrollIndicator = NO;
    [view registerNib:[UINib nibWithNibName:NSStringFromClass([UpdataViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"UpdataViewCell"];
    view.delegate = self;
    view.dataSource = self;
    view.tag = 1000;
    view.backgroundColor = [UIColor clearColor];
    UICollectionView *view1 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    view1.showsVerticalScrollIndicator = NO;
    [view1 registerNib:[UINib nibWithNibName:NSStringFromClass([UpdataViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"UpdataViewCell"];
    view1.delegate = self;
    view1.dataSource = self;
    view1.tag = 1001;
    view1.backgroundColor = [UIColor clearColor];
    UICollectionView *view2 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    view2.showsVerticalScrollIndicator = NO;
    [view2 registerNib:[UINib nibWithNibName:NSStringFromClass([UpdataViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"UpdataViewCell"];
    view2.delegate = self;
    view2.dataSource = self;
    view2.tag = 1000;
    view2.backgroundColor = [UIColor clearColor];
    UICollectionView *view3 = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) collectionViewLayout:flowLayout];
    view3.showsVerticalScrollIndicator = NO;
    [view3 registerNib:[UINib nibWithNibName:NSStringFromClass([UpdataViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"UpdataViewCell"];
    view3.delegate = self;
    view3.dataSource = self;
    view3.tag = 1000;
    view3.backgroundColor = [UIColor clearColor];
    [plish.view addSubview:view];
    [cont.view addSubview:view1];
    [hot.view addSubview:view2];
    [new.view addSubview:view3];
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UpdataViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UpdataViewCell" forIndexPath:indexPath];
    TopModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
        
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyScrollViewController" bundle:nil];
        MyScrollViewController *myVc = [storyboard instantiateInitialViewController];
        [self.navigationController pushViewController:myVc animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    
}

@end
