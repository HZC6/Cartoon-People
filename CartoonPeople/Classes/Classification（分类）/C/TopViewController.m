//
//  TopViewController.m
//  CartoonPeople
//
//  Created by mac on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "TopViewController.h"
#import <MJRefresh.h>
#import "TopModel.h"
#import <MJExtension.h>
#import "MyTableViewCell.h"
#import "MyScrollViewController.h"
@interface TopViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger index;
}
/**表视图 **/
@property(nonatomic,strong)UITableView *myTabelView;
@end

@implementation TopViewController


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
    //创建表视图
    [self _createTabelView];
    [self setupRefresh];
    index = 0;
}

#pragma mark - 刷新
- (void)setupRefresh {
    
    self.myTabelView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    // 自动改变透明度
    self.myTabelView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.myTabelView.mj_header beginRefreshing];
    
    // 自动刷新
    self.myTabelView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
}

- (void)loadNewData{
    [self.myTabelView.mj_footer endRefreshing];
    if (index == 0) {
        index = 10;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"TOP30" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic2 = [NSDictionary dictionary];
        dic2 = dic1[@"response"];
        NSArray *array = [TopModel mj_objectArrayWithKeyValuesArray:dic2[@"mangas"]];
        
        for (int i = 0 ; i<index; i++) {
            [self.dataArray addObject:array[i]];
        }

    }
    [self.myTabelView reloadData];
    // 结束刷新
    [self.myTabelView.mj_header endRefreshing];
}

- (void)loadMoreData{
    // 结束下拉
    [self.myTabelView.mj_header endRefreshing];
    if (index <30) {
        int j = (int)index;
        index += 10;
        NSString *path = [[NSBundle mainBundle]pathForResource:@"TOP30" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSDictionary *dic2 = [NSDictionary dictionary];
        dic2 = dic1[@"response"];
        NSArray *array = [TopModel mj_objectArrayWithKeyValuesArray:dic2[@"mangas"]];
        
        for (int i = j ; i<index; i++) {
            [self.dataArray addObject:array[i]];
        }
        
    }
    [self.myTabelView reloadData];
    // 结束刷新
    [self.myTabelView.mj_footer endRefreshing];

}


#pragma mark - 创建表视图
- (void)_createTabelView{
    self.myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49) style:UITableViewStylePlain];
    self.myTabelView.dataSource = self;
    self.myTabelView.delegate = self;
    self.myTabelView.rowHeight = 70;
    [self.myTabelView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MyTableViewCell"];
    [self.view addSubview:self.myTabelView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    TopModel *model = self.dataArray[indexPath.row];
    model.topNumber =  indexPath.row+1;
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyScrollViewController" bundle:nil];
    MyScrollViewController *myVc = [storyboard instantiateInitialViewController];
    [self.navigationController pushViewController:myVc animated:YES];
}


@end
