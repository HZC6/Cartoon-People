//
//  PostDetailTableViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/7.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "PostDetailTableViewController.h"
#import "PostDetailTableViewCell.h"
#import "PostHeadView.h"
#import "postDetailCellModel.h"
#import <MJExtension/MJExtension.h>

#define KscW [UIScreen mainScreen].bounds.size.width
#define KscH [UIScreen mainScreen].bounds.size.height

@interface PostDetailTableViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIView *V;
@property(nonatomic,strong)UIView *statusBarView;
@property(nonatomic,strong)UIButton *statusBarBtn;
@property(nonatomic,strong)UILabel *statusBarLabel;
@property(nonatomic,assign)CGFloat RGB;


@end

@implementation PostDetailTableViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //注册cell xib
    [self.tableView registerNib:[UINib nibWithNibName:@"PostDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //加载数据
    [self loadData];
    
    //设置头视图
    self.V = [[[NSBundle mainBundle]loadNibNamed:@"PostHeadView" owner:nil options:nil]lastObject];
    self.tableView.tableHeaderView = _V;
    //设置背景颜色弹簧效果
    self.tableView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.2];
    self.tableView.bounces = NO;
    //设置发表文章按钮
    [self publishBtn];
    //设置签到按钮
    [self setupThreeBtn];
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    //自定义状态栏
    [self setupStatusbar];
    //颜色值初始化
    _RGB = 1;
    
    
}
#pragma mark -
#pragma mark - 自定义状态栏
- (void)setupStatusbar{
    
    //自定义状态栏
    self.statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KscW, 64)];
    self.statusBarView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:117/255.0 alpha:0];
    [self.view addSubview:self.statusBarView];
    //创建返回按钮
    self.statusBarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.statusBarBtn.frame = CGRectMake(20, 25, 30, 30);
    [self.statusBarBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [self.statusBarBtn addTarget:self action:@selector(statusBarBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.statusBarBtn];
    
    //自定义状态栏标题
    self.statusBarLabel = [[UILabel alloc]initWithFrame:CGRectMake(KscW/2-100, 30, 200, 20)];
    self.statusBarLabel.text = @"妖精的尾巴";
    self.statusBarLabel.font = [UIFont boldSystemFontOfSize:17];
    self.statusBarLabel.textAlignment = NSTextAlignmentCenter;
    self.statusBarLabel.textColor = [UIColor colorWithRed:_RGB green:_RGB blue:_RGB alpha:1];
    [self.view addSubview:self.statusBarLabel];
}
#pragma mark -
#pragma mark -设置阅读、加入、签到按钮
- (void)setupThreeBtn{
    
    UIButton *siginBtn = (UIButton *)[_V viewWithTag:300];
    UIButton *readBtn = (UIButton *)[_V viewWithTag:100];
    UIButton *joinBtn = (UIButton *)[_V viewWithTag:200];
    [siginBtn addTarget:self action:@selector(siginAction:) forControlEvents:UIControlEventTouchUpInside];
    [readBtn addTarget:self action:@selector(readAction:) forControlEvents:UIControlEventTouchUpInside];
    [joinBtn addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark -
#pragma mark - siginAction方法的实现
- (void)siginAction:(UIButton *)btn{
    
    //富文本属性
    NSMutableAttributedString *attributedMessage= [[NSMutableAttributedString alloc] initWithString:@"需要加入圈子才能签到，您要加入圈子吗？" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:attributedMessage.string  preferredStyle:UIAlertControllerStyleAlert];
    // 用 KVC 修改其 没有暴露出来的
    [alertController setValue:attributedMessage forKey:@"attributedMessage"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"加入！"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [okAction setValue:[[UIColor purpleColor] colorWithAlphaComponent:1]forKey:@"titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不加入" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
    
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    
    [self presentViewController:alertController animated:YES  completion:nil];
}
#pragma mark -
#pragma mark - 阅读按钮方法
- (void)readAction:(UIButton *)btn{
    
    
}
#pragma mark -
#pragma mark - 加入按钮方法
- (void)joinAction:(UIButton *)btn{
    
    
}
#pragma mark -
#pragma mark - 设置发表文章按钮
- (void)publishBtn{
    
    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
    publishButton.frame = CGRectMake(KscW-80, KscH-110 , 50, 50);
    
    [publishButton setImage:[UIImage imageNamed:@"创建圈子"] forState:UIControlStateNormal];
    [publishButton addTarget:self action:@selector(publishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishButton];
   

}
#pragma mark -
#pragma mark - publishBtnAction点击事件
- (void)publishBtnAction:(UIButton *)btn{

    
    //富文本属性
    NSMutableAttributedString *attributedMessage= [[NSMutableAttributedString alloc] initWithString:@"登录后，才可以发帖子哟！" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:attributedMessage.string  preferredStyle:UIAlertControllerStyleAlert];
    // 用 KVC 修改其 没有暴露出来的
    [alertController setValue:attributedMessage forKey:@"attributedMessage"];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"去登陆！"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [okAction setValue:[[UIColor purpleColor] colorWithAlphaComponent:0.4]forKey:@"titleTextColor"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"算了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [cancelAction setValue:[UIColor lightGrayColor] forKey:@"titleTextColor"];
  
    [alertController addAction:okAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES  completion:nil];
    
    
}


#pragma mark -
#pragma mark -加载数据
- (void) loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"热门圈子详细内容评论" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDict = dict[@"result"];
    self.dataArray = [postDetailCellModel mj_objectArrayWithKeyValuesArray:dataDict];
    self.title = @"妖精的尾巴";
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    postDetailCellModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    postDetailCellModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //隐藏状态栏
    self.navigationController.navigationBar.hidden = YES;
    //隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
  
}


#pragma mark -
#pragma mark - 状态栏按钮返回方法
- (void)statusBarBtnAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - 滚动视图的协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y <=40 && scrollView.contentOffset.y>=0) {

        _RGB = scrollView.contentOffset.y /40;

    }
    
    if (scrollView.contentOffset.y >=40) {
        _RGB = 1.0;
    }

    [UIView animateWithDuration:0.25 animations:^{
        self.statusBarLabel.textColor = [UIColor colorWithRed:1-_RGB green:1-_RGB blue:1-_RGB alpha:1];
        self.statusBarView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:117/255.0 alpha:_RGB];
        }];
    

}



@end
