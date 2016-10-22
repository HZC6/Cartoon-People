//
//  ScroCollectionView4.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/12.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ScroCollectionView4.h"
#import "Scr4CollectionViewCell.h"

@interface ScroCollectionView4 (){
    
    UICollectionView *collectionV;
}
@property(nonatomic,strong)NSArray *dataArray;

@end
@implementation ScroCollectionView4

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        _dataArray = @[@"22",@"21",@"20",@"19",@"18",@"17",@"16",@"15",@"14",@"13",@"12",@"11",@"10",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2",@"1"];
        [self createSubviews];
        
        
        
    }
    
    return self;
}


- (void)createSubviews{
    
    UICollectionViewFlowLayout *flayout = [[UICollectionViewFlowLayout alloc]init];
    flayout.minimumInteritemSpacing = 5;
    flayout.minimumLineSpacing = 10;
    CGFloat kw = ([UIScreen mainScreen].bounds.size.width-25)/5;
    flayout.itemSize = CGSizeMake(kw + 10, 40);
    flayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 230) collectionViewLayout:flayout];
    
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    collectionV.dataSource = self;
    collectionV.delegate = self;
    collectionV.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:collectionV];
    
    //[collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [collectionV registerNib:[UINib nibWithNibName:@"Scr4CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 22;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Scr4CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.68].CGColor;
    cell.layer.borderWidth = 1;
    
    cell.numberLabel.text = self.dataArray[indexPath.row];
    
    
    
//    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
//    lable.center = cell.contentView.center;
//    lable.text = self.dataArray[indexPath.row];
//    lable.textAlignment = NSTextAlignmentCenter;
//    lable.textColor = [UIColor lightGrayColor];
//    lable.font = [UIFont systemFontOfSize:15];
//    [cell addSubview:lable];
    
    
    return cell;
}

@end
