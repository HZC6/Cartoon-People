//
//  CPRSetingViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPRSetingViewController.h"
#import "CPReadingViewController.h"
#import "CPMineCell.h"
#import "CPSettingItem.h"
#import "CPSettingGroup.h"
#import "SVProgressHUD.h"

@interface CPRSetingViewController ()

/// 组总数
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation CPRSetingViewController

static NSString *WYID = @"me";

- (NSMutableArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setupGroup0];
    [self setupGroup1];
    
    self.title = @"阅读页设置";
    
    // 注册
    [self.tableView registerClass:[CPMineCell class] forCellReuseIdentifier:WYID];
    self.navigationController.navigationBar.hidden = NO;
    
}

/// 第0组数据
- (void)setupGroup0 {
    CPSettingItem *item10 = [CPSettingItem itemWithTitle:@"显示系统状态栏"];
    item10.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item11 = [CPSettingItem itemWithTitle:@"显示底部信息栏"];
    item11.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item12 = [CPSettingItem itemWithTitle:@"隐藏虚拟键盘"];
    item12.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item13 = [CPSettingItem itemWithTitle:@"开启长按可涂鸦功能"];
    item13.type = CPSettingItemRightViewStateSwitch;
    
    NSArray *item1 = @[item10, item11, item12, item13];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item1];
    group.headerTitle = @"显示";
    [self.groups addObject:group];
    
}

/// 第1组数据
- (void)setupGroup1 {
    CPSettingItem *item20 = [CPSettingItem itemWithTitle:@"章节提醒"];
    item20.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item21 = [CPSettingItem itemWithTitle:@"音量翻页"];
    item21.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item22 = [CPSettingItem itemWithTitle:@"是否过滤番外"];
    item22.type = CPSettingItemRightViewStateSwitch;

    CPSettingItem *item23 = [CPSettingItem itemWithTitle:@"左右模式下隐藏多余白边"];
    item23.type = CPSettingItemRightViewStateSwitch;

    CPSettingItem *item24 = [CPSettingItem itemWithTitle:@"重置提醒"];
    item24.type = CPSettingItemRightViewStateAllow;
    
    NSArray *item2 = @[item20, item21, item22, item23, item24];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item2];
    group.headerTitle = @"阅读";
    [self.groups addObject:group];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CPSettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPMineCell *cell = [tableView dequeueReusableCellWithIdentifier:WYID];
    CPSettingGroup *group = self.groups[indexPath.section];
    CPSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPSettingGroup *group = self.groups[indexPath.section];
    CPSettingItem *item = group.items[indexPath.row];
    if (item.operationBlock) {
        item.operationBlock();
    } else if (item.type == CPSettingItemRightViewStateAllow) {
        if (item.desVc) {
            UIViewController *vc = [[item.desVc alloc] init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    CPSettingGroup *group = self.groups[section];
//    return group.headerTitle;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 20)];
    label.textColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:12];
    
    CPSettingGroup *group = self.groups[section];
    label.text = group.headerTitle;
    
    return label;
    
}

@end
