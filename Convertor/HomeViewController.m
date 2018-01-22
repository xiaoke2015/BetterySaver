//
//  HomeViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeTableViewCell.h"


#import "StorageViewController.h"
#import "CPUUsedViewController.h"
#import "BatteryViewController.h"
#import "DeviceViewController.h"
#import "SpeedViewController.h"
#import "MemoryViewController.h"

#import "MoreViewController.h"

#import "AppInfo.h"

#import "CurrentView.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UIView *headView;
@property (nonatomic ,assign)CGFloat cell_h;

@property (nonatomic ,strong)UIImageView *bannerImage;
@property (nonatomic ,strong)NSString *bannerUrl;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Panda assistant"];
    
    self.view.backgroundColor = RGB(50, 50, 50);
    
    
    
//    NSURL *folderURL = [NSURL fileURLWithPath:@"/Applications/"];
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error = nil;
//    NSArray *folderContents = [fileManager contentsOfDirectoryAtURL:folderURL
//                                         includingPropertiesForKeys:nil
//                                                            options:0
//                                                              error:&error];
//    
//   
//    NSLog(@"%@",folderContents);
    
    
    
    
    [self initLeftItem];
    
    [self initData];
    
    [self initHeadView];
    
    [self initTableView];
    
    
    [CurrentView loadBannerSuccess:^(NSString *aurl, NSString *aimgUrl) {
        
        [_bannerImage sd_setImageWithURL:[NSURL URLWithString:aimgUrl]];
        _bannerUrl = aurl;
    }];
    
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


- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    UIImage *image = [UIImage imageNamed:@"settings"];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateHighlighted];

    [btn addTarget:self action:@selector(leftItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
    
    [self setLeftBarWithCustomView:nil];
    
}


- (void)leftItemAction {
    
    MoreViewController * next = [[MoreViewController alloc]init];

    [self.navigationController pushViewController:next animated:YES];
}






- (void)initHeadView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];
    
    _headView.backgroundColor = RGB(230, 230, 230);
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 20, _headView.height/2 - 50, 40, 40)];
    
    image.image = [UIImage imageNamed:@"phone_image"];
    [_headView addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, _headView.height/2, SCREEM_WIDTH, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = RGB(254, 195, 45);
    label.font = FONT(24);
    [_headView addSubview:label];
    
    // 手机名称
    NSString *iPhoneName = [UIDevice currentDevice].name;
    
    label.text = iPhoneName;
    
    
    UILabel *tip = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEM_WIDTH, 20)];
    tip.textColor = RGB(100, 100, 100);
    tip.font = FONT12;
    tip.textAlignment = NSTextAlignmentCenter;
    tip.text = @"Mobile assistant protects you at all times";
    [_headView addSubview:tip];
    
    
    
    _bannerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*0.5)];

    [_headView addSubview:_bannerImage];
    
    _bannerImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
    [_bannerImage addGestureRecognizer:tap];
    _bannerImage.contentMode = UIViewContentModeScaleAspectFill;
    _bannerImage.clipsToBounds = YES;
   
}


- (void)imgTap:(UITapGestureRecognizer*)tap {
    
    if(_bannerUrl != nil){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_bannerUrl]];
    }
}




- (void)initData {
    
    
    
    _tableArr = @[
                  @{@"tag":@"1",@"image":@"device",@"text":@"Device"},
                  @{@"tag":@"2",@"image":@"storage",@"text":@"Storage"},
                  @{@"tag":@"6",@"image":@"memory",@"text":@"Memory"},
                  @{@"tag":@"3",@"image":@"CPU",@"text":@"CPU"},
                  @{@"tag":@"4",@"image":@"battery",@"text":@"Battery"},
                  @{@"tag":@"5",@"image":@"netspeed",@"text":@"Net Speed"},
                  
                  ];
    
    _cell_h = (SCREEM_HEIGHT - SCREEM_WIDTH*0.5 - 64)/_tableArr.count;
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
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
   
    _tableView.tableHeaderView = _headView;
    
//    _tableView.separatorStyle = NO;
    
    _tableView.separatorColor = RGB(25, 25, 25);
    
    _tableView.backgroundColor = RGB(50, 50, 50);

}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    cell.frame = CGRectMake(0, 0, SCREEM_WIDTH, _cell_h);
   
    NSDictionary *dic = _tableArr[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = dic[@"text"];
    cell.textLabel.font = FONT(15);
    
//    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];
    
    UIImage *image = [UIImage imageNamed:dic[@"image"]];
    
    [cell.iconBtn setImage:image forState:UIControlStateNormal];
    
    cell.iconBtn.layer.masksToBounds = YES;
    cell.iconBtn.layer.cornerRadius = 20;
    if(indexPath.row == 0){
        cell.iconBtn.backgroundColor = RGB(148, 189, 63);
    }
    else if (indexPath.row == 1){
        cell.iconBtn.backgroundColor = RGB(233, 54, 93);
    }
    else if (indexPath.row == 2){
        cell.iconBtn.backgroundColor = RGB(22, 156, 222);
    }
    else if (indexPath.row == 3){
        cell.iconBtn.backgroundColor = RGB(11, 186, 137);
    }
    else if (indexPath.row == 4){
        cell.iconBtn.backgroundColor = RGB(203, 190, 140);
    }
    else if (indexPath.row == 5){
        cell.iconBtn.backgroundColor = RGB(222, 146, 73);
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dic = _tableArr[indexPath.row];

    NSInteger tag = [dic[@"tag"] integerValue];
    
    if(tag == 1){
        
        DeviceViewController *nextVC = [[DeviceViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];

    }
    else if (tag == 2){
        
        StorageViewController *nextVC = [[StorageViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
        
    }
    else if (tag == 3){
        
        CPUUsedViewController *nextVC = [[CPUUsedViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
       
    }
    else if (tag == 4){
        
        BatteryViewController *nextVC = [[BatteryViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 5){
        
        SpeedViewController *nextVC = [[SpeedViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 6){
        
        MemoryViewController *nextVC = [[MemoryViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
}







@end
