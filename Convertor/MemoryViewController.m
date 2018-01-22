//
//  MemoryViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/9/5.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MemoryViewController.h"

#import "CircularProgressView.h"

#import "AppInfo.h"

@interface MemoryViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSArray* dataSource;

@end

@implementation MemoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Memory Usage"];
    //    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGB(50, 50, 50);
    
    //    [self initBackBtn];
    
    [self creatView];
    
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)initBackBtn {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
    //    btn.backgroundColor = [UIColor whiteColor];
    
    UIImage *img = [UIImage imageNamed:@"back_img"];
    [btn setImage:img forState:UIControlStateNormal];
    //    [btn setImage:img forState:UIControlStateHighlighted];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)backBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)creatView {
    
    
    AppInfo *appinfo = [AppInfo new];
    [appinfo GetMemoryStatistics];
    
    CGFloat scale = appinfo.scaleMemory;
    
    _tableArr = @[@"Total",@"Active",@"Inactive",@"Wired",@"Free"];
    _dataSource = @[appinfo.TotalMemory,appinfo.ActiveMemory,appinfo.InactiveMemory,
                    appinfo.WiredMemory,appinfo.FreeMemory];
    
    
    
    CircularProgressView *progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 110, 40, 220, 220)];
    
    [progressView setCurrentColor:RGB(22, 156, 222)];
    
    [self.view addSubview:progressView];
    
    [progressView showAnmiDuration:1.0 from:0 to:scale];
    
    
    progressView.detailLabel.text = [NSString stringWithFormat:@"Memory Usage"];
    
    
//    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, SCREEM_WIDTH, 20)];
//
//    label.text = appinfo.UsedMemory;//[NSString stringWithFormat:@"Used: %.2f GB",200.f];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    [self.view addSubview:label];
//
//    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, SCREEM_WIDTH, 20)];
//
//    label2.text = appinfo.TotalMemory;//[NSString stringWithFormat:@"Available: %.2f GB",300.f];
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.textColor = [UIColor whiteColor];
//    [self.view addSubview:label2];
    
}




- (void)initTableView  {
    
    CGFloat hhh = 44*5;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - hhh, self.view.frame.size.width, hhh)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, -15, 0, 0)];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, -15, 0, 0)];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    //    _tableView.separatorStyle = NO;
    
    _tableView.separatorColor = RGB(25, 25, 25);
    
    _tableView.backgroundColor = RGB(50, 50, 50);
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.selectionStyle = NO;
    cell.contentView.backgroundColor = RGB(50, 50, 50);
    cell.backgroundColor = RGB(50, 50, 50);
    
    
    cell.frame = CGRectMake(0, 0, SCREEM_WIDTH, 44);
    
    
    NSString *title = _tableArr[indexPath.row];
    NSString *text = _dataSource[indexPath.row];
    
    cell.textLabel.font = FONT(15);
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = title;
    cell.detailTextLabel.font = FONT(13);
    cell.detailTextLabel.text = text;
    
   
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}




@end
