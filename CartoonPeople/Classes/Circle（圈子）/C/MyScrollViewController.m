//
//  MyScrollViewController.m
//  CartoonPeople
//
//  Created by mac1 on 16/9/8.
//  Copyright © 2016年 hzc. All rights reserved.
//

#import "MyScrollViewController.h"
#import "ScrollTableViewCell.h"
#import "AViewCell.h"
#import "CViewCell.h"
#import "BViewCell.h"
#import "scrollConmentModel.h"
#import "YinYnagZModel.h"

#define KscW [UIScreen mainScreen].bounds.size.width
#define KscH [UIScreen mainScreen].bounds.size.height
@interface MyScrollViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //键盘高度
    CGFloat kbHeight;
    NSIndexPath *selectIndexpath;//选中的indexPath
     NSIndexPath *selectIndexpath1;
    BOOL isOpen;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldView;
@property(nonatomic,strong)UIView *statusBarView;
@property(nonatomic,strong)UIButton *statusBarBtn;
@property(nonatomic,strong)UILabel *statusBarLabel;
@property(nonatomic,assign)CGFloat RGB;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property(nonatomic,strong)NSMutableArray *headDataArray;
@property(nonatomic,strong)UIButton *openButton;
@property (strong, nonatomic) IBOutlet UIView *textfildContentV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@end

@implementation MyScrollViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}
-(NSMutableArray *)headDataArray{
    if (_headDataArray == nil) {
        _headDataArray = [NSMutableArray array];
    }
    return _headDataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //标签栏隐藏
    self.tabBarController.tabBar.hidden = YES;
    //隐藏状态栏
    self.navigationController.navigationBar.hidden = YES;
    //隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    
    //发送通知
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    [self headData];
    //设置内边距
    self.tableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    //自定义状态栏
    [self setupStatusbar];
    //设置单元格分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //注册cell xib
    [self.tableView registerNib:[UINib nibWithNibName:@"ScrollTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AViewCell" bundle:nil] forCellReuseIdentifier:@"cellA"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CViewCell" bundle:nil] forCellReuseIdentifier:@"cellC"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BViewCell" bundle:nil] forCellReuseIdentifier:@"cellB"];
    //键盘弹出
    [self createTextNoti];
    //收起键盘的手势
    [self pickKeyBoard];
    //bool
    isOpen = YES;
    //设置底部视图
    [self setupFootView];
}
- (void)setupFootView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreen_Width, 30);
    [button setTitle:@"查看所有评论" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    self.tableView.tableFooterView = button;
}
#pragma mark -
#pragma mark -加载数据
- (void)loadData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"滚动视图点击后的详细评论" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = dict[@"comments"];
    for (NSInteger i = 0; i<dataArr.count; i++) {
        NSDictionary *dict = dataArr[i];
        scrollConmentModel *model = [[scrollConmentModel alloc]init];
        model.commentContent = dict[@"commentContent"];
        model.commentHots = dict[@"commentHots"];
        model.commentTime = dict[@"commentTime"];
        model.userHeadimageUrl = dict[@"userHeadimageUrl"];
        model.userName = dict[@"userName"];
        
        [self.dataArray addObject:model];
    }
    
    
}

- (void)headData{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"阴阳宅简介" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    YinYnagZModel *model = [[YinYnagZModel alloc]init];
    model.mangaName = dict[@"response"][@"mangaName"];
    model.mangaAuthor = dict[@"response"][@"mangaAuthor"];
    model.mangaGrade = dict[@"response"][@"mangaGrade"];
    model.mangaTheme = dict[@"response"][@"mangaTheme"];
    model.mangaIntro = dict[@"response"][@"mangaIntro"];
    model.mangaNewsectionName = dict[@"response"][@"mangaNewsectionName"];
    [self.headDataArray addObject:model];
    
}
#pragma mark -
#pragma mark - 自定义状态栏
- (void)setupStatusbar{
    
    //颜色值初始化
    _RGB = 1;
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
    self.statusBarLabel.text = @"阴阳宅急便";
    self.statusBarLabel.font = [UIFont boldSystemFontOfSize:17];
    self.statusBarLabel.textAlignment = NSTextAlignmentCenter;
    self.statusBarLabel.textColor = [UIColor colorWithRed:_RGB green:_RGB blue:_RGB alpha:1];
    [self.view addSubview:self.statusBarLabel];
}
#pragma mark -
#pragma mark - 表视图的代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   
    return self.dataArray.count+3;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        
        AViewCell *cellA = [tableView dequeueReusableCellWithIdentifier:@"cellA"];
        YinYnagZModel *model = self.headDataArray[0];
        cellA.model = model;
        
        UIButton *button = (UIButton *)[cellA viewWithTag:100];
        [button addTarget:self action:@selector(openAction:) forControlEvents:UIControlEventTouchUpInside];
        cell = cellA;
        
    }else if (indexPath.row == 1){
        
        BViewCell *cellB = [tableView dequeueReusableCellWithIdentifier:@"cellB"];
        cell = cellB;
        
    }else if(indexPath.row == 2){
        
        CViewCell *cellC = [tableView dequeueReusableCellWithIdentifier:@"cellC"];
        cell = cellC;
        
    }else{
       
        ScrollTableViewCell *cellS = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        scrollConmentModel *model = self.dataArray[indexPath.row-3];
        cellS.model = model;
        
        
        cell = cellS;
    }
    
    return cell;
    
}
#pragma mark - UITableView Deleagete
//选中单元格
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中的indexPath的赋值
    selectIndexpath = indexPath;
    
    //刷新
    [tableView reloadData];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
    YinYnagZModel *model = self.headDataArray[0];
        if (selectIndexpath1.row == 1) {
            
            NSString *content = model.mangaIntro;
            //(2)属性字典 (字号大小)
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
            
            CGRect rect =  [content boundingRectWithSize:CGSizeMake(tableView.frame.size.width-16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
            model.textViewHeight = rect.size.height;
            
            return 398 + rect.size.height+8;
            
        }else{
            
            model.textViewHeight = 51;
            return 449;
        }
    
        
        
    }else if (indexPath.row == 1){
        
        return 317;
    }else if (indexPath.row == 2){
        
        return 286;
        
    }else  if (indexPath.row ==selectIndexpath.row) {
        //返回根据文字大小调节的高度
        
        //(1)获取文字内容
        scrollConmentModel *model = self.dataArray[indexPath.row-3];
        NSString *content = model.commentContent;
        
        //(2)属性字典 (字号大小)
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGRect rect =  [content boundingRectWithSize:CGSizeMake(tableView.frame.size.width-55, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        if (rect.size.height+56<100) {
            return 100;
            
        }else{
            
            return rect.size.height+70;
        }

    }else{
        return 100;
    }
    
   
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
        //self.statusBarView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:_RGB];
        self.statusBarView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:117/255.0 alpha:_RGB];
    }];
    
    
    if (scrollView.contentOffset.y > 800) {
        self.textfildContentV.hidden = NO;
        self.tableViewBottom.constant = 40;
        
        
    }else{
        self.textfildContentV.hidden = YES;
        [self.textfield resignFirstResponder];
        self.tableViewBottom.constant = 0;
        
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

//展开介绍按钮的方法
- (void)openAction:(UIButton *)btn{
    
    NSIndexPath *indexpath;
    if (isOpen) {
        
        indexpath = [NSIndexPath indexPathForRow:1 inSection:0];
    }else{
        indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    

    //选中的indexPath的赋值
    selectIndexpath1 = indexpath;
    
    //刷新
    [self.tableView reloadData];
    
    isOpen = !isOpen;
    btn.selected = !btn.selected;
}



@end
