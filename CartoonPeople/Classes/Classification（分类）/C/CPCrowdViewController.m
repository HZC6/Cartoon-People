//
//  CPCrowdViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/6.
//  Copyright © 2016年 lc. All rights reserved.
//

#import "CPCrowdViewController.h"
#import "SubjectModel.h"
#import "CAViewCell.h"
@interface CPCrowdViewController ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation CPCrowdViewController

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
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];

    
}

- (void)loadData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"人群" ofType:@"json"];
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
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CAViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CAViewCell" forIndexPath:indexPath];
    SubjectModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 109, 10);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
