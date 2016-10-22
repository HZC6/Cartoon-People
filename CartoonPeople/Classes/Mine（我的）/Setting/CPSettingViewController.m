//
//  CPSettingViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPSettingViewController.h"
#import "CPReadingViewController.h"
#import "CPMineCell.h"
#import "CPSettingItem.h"
#import "CPSettingGroup.h"
#import "SVProgressHUD.h"

@interface CPSettingViewController ()

/// 组总数
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation CPSettingViewController

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
    
    self.title = @"设置";
    
    // 注册
    [self.tableView registerClass:[CPMineCell class] forCellReuseIdentifier:WYID];
    self.navigationController.navigationBar.hidden = NO;
    
}

/// 第0组数据
- (void)setupGroup0 {
    CPSettingItem *item10 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"阅读设置"] title:@"阅读设置"];
    item10.type = CPSettingItemRightViewStateImage;
    __weak typeof(self) weakSelf = self;
    item10.operationBlock = ^ {
        CPReadingViewController *readingVc = [[CPReadingViewController alloc] init];
        [weakSelf.navigationController pushViewController:readingVc animated:YES];
    };
    
    CPSettingItem *item11 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"隐私设置"] title:@"隐私设置"];
    item11.type = CPSettingItemRightViewStateImage;
    item11.operationBlock = ^ {
        
    };
    
    CPSettingItem *item12 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"隐私设置"] title:@"添加已下载漫画"];
    item12.type = CPSettingItemRightViewStateImage;
    item12.operationBlock = ^ {
        
    };

    CPSettingItem *item13 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"隐私设置"] title:@"下载目录"];
    item13.type = CPSettingItemRightViewStateImage;
    item13.operationBlock = ^ {
        
    };

    CPSettingItem *item14 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"清除缓存"] title:@"清除缓存"];
    item14.type = CPSettingItemRightViewStateImage;
    item14.operationBlock = ^ {
        
    };

    
    NSArray *item1 = @[item10, item11, item12, item13, item14];
    CPSettingGroup *group = [CPSettingGroup groupWithItems:item1];
    [self.groups addObject:group];
    
}

/// 第1组数据
- (void)setupGroup1 {
    CPSettingItem *item20 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"关于漫画人"] title:@"关于漫画人"];
    item20.type = CPSettingItemRightViewStateImage;
    __weak typeof(self) weakSelf = self;
    item20.operationBlock = ^ {
        
    };
    
    
    CPSettingItem *item21 = [CPSettingItem itemWithIcon:[UIImage imageNamed:@"隐私设置"] title:@"检查更新"];
    item21.type = CPSettingItemRightViewStateImage;
    item21.operationBlock = ^ {
        
    };
    
    
    NSArray *item2 = @[item20, item21];
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



@end
