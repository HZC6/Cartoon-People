//
//  RankingListViewController.m
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "RankingListViewController.h"
#import "CPSlideView.h"
#import "TopViewController.h"
#import "TopModel.h"
#import <MJExtension.h>
#import "MyTableViewCell.h"
#import "MyScrollViewController.h"

@interface RankingListViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation RankingListViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //导航栏不隐藏
    self.navigationController.navigationBar.hidden = NO;
    
    
}
- (NSMutableArray *)data1{
    if (!_data1) {
        _data1 = [NSMutableArray array];
    }
    return _data1;
}
- (NSMutableArray *)data2{
    if (!_data2) {
        _data2 = [NSMutableArray array];
    }
    return _data2;
}
- (NSMutableArray *)data3{
    if (!_data3) {
        _data3 = [NSMutableArray array];
    }
    return _data3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
    [self createChild];
}

- (void)createChild{
    TopViewController *top = [[TopViewController alloc]init];
    UIViewController *new = [[UIViewController alloc]init];
    UIViewController *collection = [[UIViewController alloc]init];
    UIViewController *tu = [[UIViewController alloc]init];
    NSArray *slideArray = @[@{@"TOP30" : top}, @{@"新番" : new}, @{@"收藏榜" : collection}, @{@"吐槽榜" : tu}];
    CPSlideView  *cp = [[CPSlideView alloc]initWithFrame:CGRectMake(0, 64,kScreenWidth, kScreenHeight) WithViewControllers:slideArray];
    UITableView *tv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    tv1.dataSource = self;
    tv1.delegate = self;
    tv1.rowHeight = 70;
    tv1.tag = 1000;
    [tv1 registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [new.view addSubview:tv1];
    UITableView *tv2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    tv2.dataSource = self;
    tv2.delegate = self;
    tv2.rowHeight = 70;
    tv2.tag = 2000;
    [tv2 registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [collection.view addSubview:tv2];
    
    UITableView *tv3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    tv3.dataSource = self;
    tv3.delegate = self;
    tv3.rowHeight = 70;
    tv3.tag = 3000;
    [tv3 registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [tu.view addSubview:tv3];
    
    [self.view addSubview:cp];
}



- (void)loadData{
    //新番
    NSString *path = [[NSBundle mainBundle]pathForResource:@"新番" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dic2 = [NSDictionary dictionary];
    dic2 = dic1[@"response"];
    
    //收藏榜
    NSString *path1 = [[NSBundle mainBundle]pathForResource:@"收藏榜" ofType:@"json"];
    NSData *data1 = [NSData dataWithContentsOfFile:path1];
    
    NSDictionary *dic3 = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic4 = [NSDictionary dictionary];
    dic4 = dic3[@"response"];
    
    //吐槽榜
    NSString *path2 = [[NSBundle mainBundle]pathForResource:@"吐槽榜" ofType:@"json"];
    NSData *data2 = [NSData dataWithContentsOfFile:path2];
    
    NSDictionary *dic5 = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
    
    NSDictionary *dic6 = [NSDictionary dictionary];
    dic6 = dic5[@"response"];
    
    NSArray *array = [TopModel mj_objectArrayWithKeyValuesArray:dic2[@"mangas"]];
    NSArray *array1 = [TopModel mj_objectArrayWithKeyValuesArray:dic4[@"mangas"]];
    NSArray *array2 = [TopModel mj_objectArrayWithKeyValuesArray:dic6[@"mangas"]];
    for (int i = 0 ; i<array.count; i++) {
        [self.data1 addObject:array[i]];
    }
    for (int i = 0 ; i<array1.count; i++) {
        [self.data2 addObject:array1[i]];
    }
    for (int i = 0 ; i<array2.count; i++) {
        [self.data3 addObject:array2[i]];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 1000) {
        return self.data1.count;
    }else if (tableView.tag == 2000){
        return self.data2.count;
    }else if (tableView.tag == 3000){
        return self.data3.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    TopModel *model = [[TopModel alloc]init];
    if (tableView.tag == 1000) {
        model = self.data1[indexPath.row];
    }else if(tableView.tag == 2000){
        model = self.data2[indexPath.row];
    }else if(tableView.tag == 3000){
        model = self.data3[indexPath.row];
    }
    model.topNumber = indexPath.row+1;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyScrollViewController" bundle:nil];
    MyScrollViewController *myVc = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:myVc animated:YES];
}

@end
