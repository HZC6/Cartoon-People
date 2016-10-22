//
//  CPGameViewController.m
//  CartoonPeople
//
//  Created by mac2 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "CPGameViewController.h"
#import "CPGameCell.h"
#import "CPGameBagCell.h"
#import "CPGameHotCell.h"
#import "CPGameGroup.h"
#import "CPGameItem.h"
#import "CPhotClubItem.h"
#import "CPhotGiftItem.h"
#import <MJExtension.h>
#import "CPLoopImageView.h"

@interface CPGameViewController () <CPImageLoopDelegate>

/** 组模型 */
@property (nonatomic, strong) NSMutableArray *groups;

@end

@implementation CPGameViewController

static NSString *CPItemID = @"item";
static NSString *CPHotGiftItemID = @"gift";
static NSString *CPHotClubItemID = @"club";

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)groups {
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHeadView];
    
    self.tableView.sectionFooterHeight = 0;
    
    // 加载数据
    [self loadData];
    
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPGameCell class]) bundle:nil] forCellReuseIdentifier:CPItemID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPGameBagCell class]) bundle:nil] forCellReuseIdentifier:CPHotGiftItemID];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CPGameHotCell class]) bundle:nil] forCellReuseIdentifier:CPHotClubItemID];
    
}

#pragma mark - 
- (void)setupHeadView {
    
    // 头部滚动视图
    UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    // 添加头部视图
    CPLoopImageView *loopView = [[CPLoopImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    loopView.delegate = self;
    loopView.timeInterval = 2.0f;
    loopView.isAutoScroll = YES;
    
    NSMutableArray *imageArray = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"游戏中心头视图" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dictData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *array = dictData[@"response"][@"banners"];
    
    for (int i = 0; i < array.count; i++) {

        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:array[i][@"imgUrl"]] placeholderImage:[UIImage imageNamed:@"默认头像1"]];
        [imageArray addObject:imageView];
        
    }
    
    loopView.imageArray = imageArray;
    
    [headview addSubview:loopView];
    
    self.tableView.tableHeaderView = headview;

}

#pragma mark - 加载数据
- (void)loadData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"游戏中心" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSArray *arrayGroup = dataDic[@"response"][@"themes"];
    
    // 本期主打
    NSArray *array0 = [CPGameItem mj_objectArrayWithKeyValuesArray:arrayGroup[0][@"gameItems"]];
    CPGameGroup *group0 = [CPGameGroup groupWithGameItems:array0];
    group0.theme = arrayGroup[0][@"theme"];
    group0.type = [arrayGroup[0][@"type"] intValue];
    [self.groups addObject:group0];
    
    // 精品推荐
    NSArray *array1 = [CPGameItem mj_objectArrayWithKeyValuesArray:arrayGroup[1][@"gameItems"]];
    CPGameGroup *group1 = [CPGameGroup groupWithGameItems:array1];
    group1.theme = arrayGroup[1][@"theme"];
    group1.type = [arrayGroup[1][@"type"] intValue];
    [self.groups addObject:group1];

    // 热门圈子
    NSArray *array2 = [CPhotClubItem mj_objectArrayWithKeyValuesArray:arrayGroup[2][@"hotClubItems"]];
    CPGameGroup *group2 = [CPGameGroup groupWithHotClubItems:array2];
    group2.theme = arrayGroup[2][@"theme"];
    group2.type = [arrayGroup[2][@"type"] intValue];
    [self.groups addObject:group2];

    // 热门礼包
    NSArray *array3 = [CPhotGiftItem mj_objectArrayWithKeyValuesArray:arrayGroup[3][@"hotGiftItems"]];
    CPGameGroup *group3 = [CPGameGroup groupWithHotGiftItems:array3];
    group3.theme = arrayGroup[3][@"theme"];
    group3.type = [arrayGroup[3][@"type"] intValue];
    [self.groups addObject:group3];
    
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CPGameGroup *group = self.groups[section];

    if (group.type == 0) {
        
        return group.gameItems.count;
        
    } else if (group.type == 1) {

        return group.hotGiftItems.count;
        
    } else if (group.type == 2) {
        
        return group.hotClubItems.count;
        
    } else {
        
        return group.gameItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPGameGroup *group = self.groups[indexPath.section];
    
    if (group.type == 0) {
        
        CPGameItem *item = group.gameItems[indexPath.row];
        CPGameCell *cell = [tableView dequeueReusableCellWithIdentifier:CPItemID];
        cell.item = item; 
        return cell;
        
    } else if (group.type == 1) {
        
        CPhotGiftItem *item = group.hotGiftItems[indexPath.row];
        CPGameBagCell *cell = [tableView dequeueReusableCellWithIdentifier:CPHotGiftItemID];
        cell.item = item;
        return cell;
        
    } else if (group.type == 2) {
        
        CPhotClubItem *item = group.hotClubItems[indexPath.row];
        CPGameHotCell *cell = [tableView dequeueReusableCellWithIdentifier:CPHotClubItemID];
        cell.item = item;
        return cell;
        
    } else {
        
        CPGameItem *item = group.gameItems[indexPath.row];
        CPGameCell *cell = [tableView dequeueReusableCellWithIdentifier:CPItemID];
        cell.item = item;
        return cell;
    }
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        CPGameGroup *group = self.groups[section];
        
        UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *headlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 30)];
        headlabel.text = group.theme;
        headlabel.font = [UIFont systemFontOfSize:13];
        headlabel.textColor = [UIColor lightGrayColor];
        
        [headview addSubview:headlabel];
        
        return headview;
        
    } else {
        
        CPGameGroup *group = self.groups[section];
        
        UIView *headview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        UILabel *headlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, 30)];
        headlabel.text = group.theme;
        headlabel.font = [UIFont systemFontOfSize:13];
        headlabel.textColor = [UIColor lightGrayColor];
        
        UIButton *headBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, 30)];
        [headBtn setTitle:@"更多" forState:UIControlStateNormal];
        headBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [headBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [headBtn setImage:[UIImage imageNamed:@"jt"] forState:UIControlStateNormal];
        headBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
        headBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 60, 10, 10);
        
        [headview addSubview:headlabel];
        [headlabel addSubview:headBtn];
        
        return headview;

    }
    
}

#pragma mark - ALCarouselDelegate
-(void)didClickPage:(CPLoopImageView  *)view atIndex:(NSInteger)index
{
    NSLog(@"%lu",index);
}


@end
