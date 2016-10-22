//
//  CPReadingViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPReadingViewController.h"
#import "CPRSetingViewController.h"
#import "CPMineCell.h"
#import "CPSettingItem.h"
#import "CPSettingGroup.h"
#import "SVProgressHUD.h"


@interface CPReadingViewController ()

/// 组总数
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation CPReadingViewController

static NSString *WYID = @"me";

- (NSMutableArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];


    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setupGroup0];
    [self setupGroup1];
    
    self.title = @"阅读设置";
    
    // 注册
    [self.tableView registerClass:[CPMineCell class] forCellReuseIdentifier:WYID];
    self.navigationController.navigationBar.hidden = NO;
    
}

/// 第0组数据
- (void)setupGroup0 {
    CPSettingItem *item10 = [CPSettingItem itemWithTitle:@"阅读页设置"];
    item10.type = CPSettingItemRightViewStateAllow;
    __weak typeof(self) weakSelf = self;
    item10.operationBlock = ^ {
        CPRSetingViewController *rsingVc = [[CPRSetingViewController alloc] init];
        [weakSelf.navigationController pushViewController:rsingVc animated:YES];
    };
    
    NSArray *item1 = @[item10];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item1];
    [self.groups addObject:group];
    
}

/// 第1组数据
- (void)setupGroup1 {
    CPSettingItem *item20 = [CPSettingItem itemWithTitle:@"仅WIFI时下载"];
    item20.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item21 = [CPSettingItem itemWithTitle:@"收藏更新提醒"];
    item21.type = CPSettingItemRightViewStateSwitch;
    
    CPSettingItem *item22 = [CPSettingItem itemWithTitle:@"夜间模式"];
    item22.type = CPSettingItemRightViewStateSwitch;
    item22.operationBlock = ^ {
        
    };

    
    NSArray *item2 = @[item20, item21, item22];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item2];
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
    return 10;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
