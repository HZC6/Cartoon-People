//
//  ScroCollectionView3.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/10.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ScroCollectionView3.h"
#import "ImagVCollectionViewCell.h"
#import "recommendedModel.h"

@interface ScroCollectionView3 (){
 
        UICollectionView *collectionV;
   
}

@property(nonatomic,strong)NSMutableArray *dataArray;

@end
@implementation ScroCollectionView3

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        [self loadDatas];
        [self createSubviews];
        
    }
    
    return self;
}

- (void)loadDatas{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"滚动视图点击后的推荐漫画内容" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = dict[@"mangas"];
    for (int i = 0; i<dataArr.count; i++) {
        recommendedModel *model = [[recommendedModel alloc]init];
        model.mangaCoverimageUrl = dataArr[i][@"mangaCoverimageUrl"];
        model.mangaName = dataArr[i][@"mangaName"];
        [self.dataArray addObject:model];
    }
    
}

- (void)createSubviews{
    
    UICollectionViewFlowLayout *flayout = [[UICollectionViewFlowLayout alloc]init];
    flayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flayout.minimumInteritemSpacing = 5;
    flayout.minimumLineSpacing = 10;
    CGFloat kw = ([UIScreen mainScreen].bounds.size.width-20)/3;
    flayout.itemSize = CGSizeMake(kw - 20, 150);
    flayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 39, [UIScreen mainScreen].bounds.size.width, 156) collectionViewLayout:flayout];
    
    //[collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.showsHorizontalScrollIndicator = NO;
    
    collectionV.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:collectionV];
    
    //[collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionV registerNib:[UINib nibWithNibName:@"ImagVCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImagVCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.68].CGColor;
    //cell.layer.borderWidth = 1;
    
    recommendedModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}




@end
