//
//  HotCircleTableViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "HotCircleTableViewController.h"
#import "MyScrollvView.h"
#import "HotCircleTableViewCell.h"
#import <MJExtension/MJExtension.h>
#import "HotCircleHeadViewModel.h"
#import "HotCirecleCellModel.h"
#import "PostDetailTableViewController.h"

@interface HotCircleTableViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *cellDataArr;

@end

@implementation HotCircleTableViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(NSMutableArray *)cellDataArr{
    if (_cellDataArr == nil) {
        _cellDataArr = [NSMutableArray array];
    }
    return _cellDataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表格头尾视图
    [self setupHeadView];
    //加载数据
    [self loadData];

    //注册xib
    [self.tableView registerNib:[UINib nibWithNibName:@"HotCircleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell" ];
    
    //表格的设置
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 90, 0);
    self.tableView.rowHeight = 80;
    
}
#pragma mark -
#pragma mark -加载数据
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cellData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = dict[@"result"];
    for (int i = 0; i<dataArr.count; i++) {
        NSDictionary *dict = dataArr[i];
        HotCirecleCellModel *model = [[HotCirecleCellModel alloc]init];
        model.name = dict[@"name"];
        model.cover = dict[@"cover"];
        model.vitalityString = dict[@"vitalityString"];
        model.lastPostContent = dict[@"lastPostContent"];
        model.totalMembers = dict[@"totalMembers"];
        model.totalPosts = dict[@"totalPosts"];
        
        [self.cellDataArr addObject:model];
    }
    
    
    
}
#pragma mark -
#pragma mark - 设置表格头尾视图
- (void)setupHeadView{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"热门圈子头部滑动视图" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDict = dict[@"banners"];
    self.dataArray = [HotCircleHeadViewModel mj_objectArrayWithKeyValuesArray:dataDict];
    
    MyScrollvView *scrollView = [[MyScrollvView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 200)];
    
    NSMutableArray *imagNameArr = [NSMutableArray array];
    NSMutableArray *labelNameArr = [NSMutableArray array];
    for (int i = 0; i<self.dataArray.count; i++) {
        
        HotCircleHeadViewModel *model = self.dataArray[i];
        
        [imagNameArr addObject:model.imgUrl];
        [labelNameArr addObject:model.title];
    }
    
    scrollView.imageNames = imagNameArr;
    scrollView.labelNames = labelNameArr;

    self.tableView.tableHeaderView = scrollView;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,30)];
    label.text = @"没有更多";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = label;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.cellDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    HotCirecleCellModel *model = self.cellDataArr[indexPath.row];
    cell.model = model;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
       
        PostDetailTableViewController *postVc = [[PostDetailTableViewController alloc]init];
        
        [self.navigationController pushViewController:postVc animated:YES];
   
    

    
    
}




@end
