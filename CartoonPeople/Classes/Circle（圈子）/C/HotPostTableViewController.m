//
//  HotPostTableViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/6.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "HotPostTableViewController.h"
#import "HotPostTableViewCell.h"
#import "HotPostCellModel.h"
#import <MJExtension/MJExtension.h>
#import "PostDetailTableViewController.h"
#import "ClidckHotPostTableViewController.h"

@interface HotPostTableViewController ()
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HotPostTableViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册xib
    [self.tableView registerNib:[UINib nibWithNibName:@"HotPostTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    //加载数据
    [self loadData];
    
    //表格的设置
    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 80, 0);
    self.tableView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    label.text = @"没有更多";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor lightGrayColor];
    self.tableView.tableFooterView = label;
}

#pragma mark -
#pragma mark -加载数据
- (void) loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"hotPost" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDict = dict[@"result"];
    self.dataArray = [HotPostCellModel mj_objectArrayWithKeyValuesArray:dataDict];
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
   
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];

    HotPostCellModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HotPostCellModel *model = self.dataArray[indexPath.row];

    return  model.cellHeight;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ClidckHotPostTableViewController" bundle:nil];
    ClidckHotPostTableViewController *clickHotvc = [storyboard instantiateInitialViewController];
    //ClidckHotPostTableViewController *clickHotVc = [[ClidckHotPostTableViewController alloc]init];
    [self.navigationController pushViewController:clickHotvc animated:YES];
}


@end
