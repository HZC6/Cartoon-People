//
//  UpdataViewController.m
//  CartoonPeople
//
//  Created by mac on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "UpdataViewController.h"
#import "TopModel.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "UpdataViewCell.h"
#import "MyScrollViewController.h"
@interface UpdataViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>{
    
}

@end

@implementation UpdataViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = _type;
    self.tabBarController.tabBar.hidden = YES;
    [self loadNewData];
    [self createView];
}

#pragma mark - 加载数据
- (void)loadNewData{
    NSString *path = [[NSBundle mainBundle]pathForResource:_type ofType:@"json"];
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
    [self.view addSubview:view];
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


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyScrollViewController" bundle:nil];
    MyScrollViewController *myVc = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:myVc animated:YES];
}

@end
