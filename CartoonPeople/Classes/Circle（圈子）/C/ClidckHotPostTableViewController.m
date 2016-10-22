//
//  ClidckHotPostTableViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/11.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "ClidckHotPostTableViewController.h"
#import "ClickHotpostCell.h"
#import "ClickHotpostHeadCell.h"
#import "ClickHotpostCellModel.h"
#import "ClickHotpostHeadViewModel.h"

@interface ClidckHotPostTableViewController ()<UITabBarDelegate,UITableViewDataSource>{
    //键盘高度
    CGFloat kbHeight;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldView;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArr;


@end

@implementation ClidckHotPostTableViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%lf",self.textFieldView.constant);
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

-(NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell xib
    [self.tableView registerNib:[UINib nibWithNibName:@"ClickHotpostCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ClickHotpostHeadCell" bundle:nil] forCellReuseIdentifier:@"headcell"];
    
    
    //加载数据
    [self headData];
    [self loadData];
    
    //键盘弹出
    [self createTextNoti];
    [self pickKeyBoard];
    
    NSLog(@"------%lf",self.textFieldView.constant);
    
}

#pragma mark -
#pragma mark - 加载数据
- (void)headData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"热们帖子点击后的说说和图片" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDict = dict[@"response"];
    
    ClickHotpostHeadViewModel *model = [[ClickHotpostHeadViewModel alloc ]init];
    
    model.author = dataDict[@"author"];
    model.content = dataDict[@"content"];
    model.postTime = dataDict[@"postTime"];
    model.pictures = dataDict[@"pictures"];
    model.likeTotal = dataDict[@"likeTotal"];
    model.likers = dataDict[@"likers"];
    [self.dataArr addObject:model];
    
    
    
    
    
}
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"热门帖子点击后的评论" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = dict[@"result"];
    for (int i=0; i<dataArr.count; i++) {
        ClickHotpostCellModel *model = [[ClickHotpostCellModel alloc]init];
        model.content = dataArr[i][@"content"];
        model.author = dataArr[i][@"author"];
        model.postTime = dataArr[i][@"postTime"];
        model.likeTotal = dataArr[i][@"likeTotal"];
        
        [self.dataArray addObject:model];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        ClickHotpostHeadCell *headcell = [tableView dequeueReusableCellWithIdentifier:@"headcell"];
        
        ClickHotpostHeadViewModel *model = self.dataArr[indexPath.row];
        
        headcell.model = model;
        
        cell = headcell;
        
    }else{
        
        ClickHotpostCell *postcell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        ClickHotpostCellModel *model = self.dataArray[indexPath.row - 1];
        postcell.model = model;
        
        cell = postcell;
        
    }
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        ClickHotpostHeadViewModel *model = self.dataArr[0];
        return model.cellHeight;
        
    }else{
        
        
        return 100;
    }
    
    
}

#pragma mark -
#pragma mark -创建键盘弹出的通知
- (void)createTextNoti{
    
    //键盘通知
    //当键盘弹出的时候  执行kbWillShow:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //当键盘消失的时候 执行kbHideShow:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kbHideShow:) name:UIKeyboardWillHideNotification object:nil];
}

//键盘弹出 调整约束的高度
- (void)kbWillShow:(NSNotification *)noti
{
    // 获取键盘的高度  首先获取当前键盘的 Rect
    CGRect kbFram = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    kbHeight = kbFram.size.height;
    
    // 把约束改掉
    self.textFieldView.constant = kbHeight ;
    
    [UIView animateWithDuration:0.35 delay:0 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
        // 布控子视图
        [self.view layoutIfNeeded];
        
        
        
    } completion:nil];
}


//键盘收起
- (void)kbHideShow:(NSNotification *)noti
{
    // 把约束改成开始的 0
    self.textFieldView.constant = 0 ;
    
    [UIView animateWithDuration:0.25 delay:0 options: UIViewAnimationOptionCurveEaseInOut  animations:^{
        // 布控子视图
        [self.view layoutIfNeeded];
        
        
        
    } completion:nil];
    
    
}

//收齐键盘的点击事件
- (void)pickKeyBoard{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self kbHideShow:nil];
    [self.textfield resignFirstResponder];
    
}
//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}




@end
