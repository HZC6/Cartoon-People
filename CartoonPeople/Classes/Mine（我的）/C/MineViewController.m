//
//  MineViewController.m
//  Cartoon people
//
//  Created by mac1 on 16/9/5.
//  Copyright © 2016年 lc. All rights reserved.
//

#import "MineViewController.h"
#import "CPLoginViewController.h"
#import "CPWebTowViewController.h"
#import "CPWebViewController.h"
#import "CPGameViewController.h"
#import "CPHeadView.h"
#import "CPMineCell.h"
#import "CPSettingItem.h"
#import "CPSettingGroup.h"
#import "SVProgressHUD.h"

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

/// 组总数
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation MineViewController

static NSString *WYID = @"me";

- (NSMutableArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 调整header和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    CPHeadView *headView = [CPHeadView headView];
    headView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200);
    self.tableView.tableHeaderView = headView;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    // 注册
    [self.tableView registerClass:[CPMineCell class] forCellReuseIdentifier:WYID];
    
    self.navigationController.navigationBar.hidden = YES;
    
}

/// 第0组数据
- (void)setupGroup0 {
    CPSettingItem *item10 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"基友圈"] title:@"基友圈"];
    item10.type = CPSettingItemRightViewStateImage;
    __weak typeof(self) weakSelf = self;
    item10.operationBlock = ^ {
        CPLoginViewController *loginVc = [CPLoginViewController shareLoginViewController];
        [weakSelf.navigationController pushViewController:loginVc animated:YES];
    };
    
    CPSettingItem *item11 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"我的日常"] title:@"我的日常"];
    item11.type = CPSettingItemRightViewStateImage;
    item11.operationBlock = ^ {
        CPLoginViewController *loginVc = [CPLoginViewController shareLoginViewController];
        [weakSelf.navigationController pushViewController:loginVc animated:YES];
    };
    
    NSArray *item1 = @[item10, item11];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item1];
    [self.groups addObject:group];

}

/// 第1组数据
- (void)setupGroup1 {
    CPSettingItem *item20 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"消息"] title:@"消息"];
    item20.type = CPSettingItemRightViewStateImage;
    
    CPSettingItem *item21 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"分享有礼"] title:@"分享《漫画人》给好友"];
    item21.type = CPSettingItemRightViewStateImage;
    
    NSArray *item2 = @[item20, item21];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item2];
    [self.groups addObject:group];
}

/// 第2组数据
- (void)setupGroup2 {
    
    __weak typeof(self) weakSelf = self;
    CPSettingItem *item30 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"008"] title:@"新世纪福音战士OL" subTitle:@"立入禁止，EVA暴走觉醒出击"];
    item30.type = CPSettingItemRightViewStateSubTitle;
    item30.operationBlock = ^ {
        CPWebViewController *web = [[CPWebViewController alloc] init];
        [weakSelf.navigationController pushViewController:web animated:YES];
    };

    CPSettingItem *item31 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"013"] title:@"冒险与挖矿" subTitle:@"最电竞休闲手游，已登陆漫画人"];
    item31.type = CPSettingItemRightViewStateSubTitle;
    item31.operationBlock = ^ {
        CPWebTowViewController *web = [[CPWebTowViewController alloc] init];
        [weakSelf.navigationController pushViewController:web animated:YES];
    };
    
    CPSettingItem *item32 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"游戏中心"] title:@"游戏中心"];
    item32.type = CPSettingItemRightViewStateImage;
    item32.operationBlock = ^ {
        CPGameViewController *gameVc = [[CPGameViewController alloc] initWithStyle:UITableViewStyleGrouped];
        [weakSelf.navigationController pushViewController:gameVc animated:YES];
    };


    CPSettingItem *item33 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"意见反馈"] title:@"意见反馈"];
    item33.type = CPSettingItemRightViewStateImage;

    
    NSArray *item3 = @[item30, item31, item32, item33];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item3];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        return 80;
    } else if (indexPath.section == 2 && indexPath.row == 1) {
        return 80;
    }
    
    return 44;
}

@end
