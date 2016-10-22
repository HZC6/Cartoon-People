//
//  CPAreaViewController.m
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPAreaViewController.h"
#import "SubjectModel.h"
#import "CAViewCell.h"
#import "RankingListViewController.h"
#import "UpdataViewController.h"
#import "TypeViewController.h"
#import "JFJumpToControllerManager.h"
@interface CPAreaViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation CPAreaViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.itemSize = CGSizeMake((kScreenWidth-40)/3, 90);
    
    UICollectionView *view = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) collectionViewLayout:flowLayout];
    view.showsVerticalScrollIndicator = NO;
    [view registerNib:[UINib nibWithNibName:NSStringFromClass([CAViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"CAViewCell"];
    view.delegate = self;
    view.dataSource = self;
    view.tag = 1000;
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
}

#pragma mark - 加载数据
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"题材" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic2 = [NSDictionary dictionary];
    dic2 = dic1[@"response"];
    NSArray *array = [NSArray alloc];
    array = dic2[@"mangaSubcategory"];
    for (NSDictionary *dic in array) {
        SubjectModel *model = [[SubjectModel alloc]init];
        model.subcategoryName = dic[@"subcategoryName"];
        model.subcategoryId = (NSInteger)dic[@"subcategoryId"];
        model.subcategoryImgUrl = dic[@"subcategoryImgUrl"];
        [self.dataArray addObject:model];
    }
}

#pragma mark - <UICollectionViewDataSource, UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%ld",collectionView.tag);
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CAViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CAViewCell" forIndexPath:indexPath];
    SubjectModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RankingListViewController *rank = [[RankingListViewController alloc]init];
        [[JFJumpToControllerManager shared].navigation.childViewControllers[1] pushViewController:rank animated:YES];
    }else if (indexPath.row == 1){
        UpdataViewController *updata = [[UpdataViewController alloc]init];
        updata.type = @"最近更新";
        [[JFJumpToControllerManager shared].navigation.childViewControllers[1] pushViewController:updata animated:YES];
    }else if (indexPath.row == 2){
        UpdataViewController *new = [[UpdataViewController alloc]init];
        new.type = @"新番收录";
        [[JFJumpToControllerManager shared].navigation.childViewControllers[1] pushViewController:new animated:YES];
    }else{
        SubjectModel *model = self.dataArray[indexPath.row];
        TypeViewController *type = [[TypeViewController alloc]init];
        type.type = model.subcategoryName;
        [[JFJumpToControllerManager shared].navigation.childViewControllers[1] pushViewController:type animated:YES];
    }
}



- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 109, 10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
