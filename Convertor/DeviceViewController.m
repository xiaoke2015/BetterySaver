//
//  DeviceViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "DeviceViewController.h"

#import "AppInfo.h"

@interface DeviceViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (strong,nonatomic)NSArray*tableArr2;
@property (nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation DeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Device"];
    
    self.view.backgroundColor = RGB(50, 50, 50);
    
    [self initData];
    
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


- (void)initData {
    
    
    // 手机名称
    NSString *iPhoneName = [UIDevice currentDevice].name;
    // 手机类型
    NSString *model = [UIDevice currentDevice].model;
    // 系统类型
    NSString *systemName = [UIDevice currentDevice].systemName;
    // 系统版本
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    
    // 地区性 手机类型
//    NSString *localizedModel = [UIDevice currentDevice].localizedModel;
//    
//    // UUID
//    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    
    // 运行商    
    NSString *carrier = [AppInfo carrierName];
    
    
    NSString *ip = [AppInfo getCurrentLocalIP];
    
    //当前网络
    NSString *LocalIP = ip == nil?@"":ip ;
    
    NSString *wifi = [AppInfo getCurreWiFiName];
    //当前网络
    NSString *WiFiName = wifi == nil?@"":wifi;
    
#pragma mark 亮度
    
    UIScreen *screen = [UIScreen mainScreen];
    NSString *Brightness = [NSString stringWithFormat:@"%.2f",screen.brightness];
    
    NSString *screensize = [NSString stringWithFormat:@"%@*%@",@(SCREEM_WIDTH),@(SCREEM_HEIGHT)];
    
    
    _tableArr = @[
                  @{@"tag":@"1",@"image":@"IPhoneName",@"text":iPhoneName},
                  @{@"tag":@"2",@"image":@"Model",@"text":model},
                  @{@"tag":@"3",@"image":@"SystemName",@"text":systemName},
                  @{@"tag":@"4",@"image":@"SystemVersion",@"text":systemVersion},
//                  @{@"tag":@"5",@"image":@"localizedModel",@"text":localizedModel},
//                  @{@"tag":@"6",@"image":@"identifierNumber",@"text":identifierNumber},
                  @{@"tag":@"6",@"image":@"Carrier",@"text":carrier},
                  @{@"tag":@"6",@"image":@"Brightness",@"text":Brightness},
                  @{@"tag":@"6",@"image":@"Screensize",@"text":screensize},
                  @{@"tag":@"6",@"image":@"LocalIP",@"text":LocalIP},
                  @{@"tag":@"6",@"image":@"WiFiName",@"text":WiFiName},
                  
                  ];
    
    _tableArr2 = @[
//                  @{@"tag":@"1",@"image":@"iPhoneName",@"text":iPhoneName},
                  @{@"tag":@"2",@"image":@"Bluetooth",@"text":@"YES"},
                  @{@"tag":@"3",@"image":@"Wi-Fi",@"text":@"YES"},
                  @{@"tag":@"4",@"image":@"Rear camera",@"text":@"YES"},
         
                  @{@"tag":@"4",@"image":@"Front camera",@"text":@"YES"},
                  @{@"tag":@"4",@"image":@"Three axis gyroscope",@"text":@"YES"},
                  @{@"tag":@"4",@"image":@"Orientation sensor",@"text":@"NO"},
                  @{@"tag":@"4",@"image":@"Fingerprint identification",@"text":@"YES"},
                  ];
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64)];
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



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 30)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEM_WIDTH - 20, 30)];
    label.textColor = RGB(240, 240, 240);
    label.font = FONT(12);
    headView.backgroundColor = RGB(25, 25, 25);
    if(section == 0){
        label.text = @"System Information";
    }
    else if (section == 1){
        label.text = @"Hardware Information";
    }
    
    [headView addSubview:label];
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.1)];
    
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == 0){
        return _tableArr.count;
    }
    else if ( section == 1){
        return _tableArr2.count;
    }
    
    return 0;
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
    
    if(indexPath.section == 0){
        
        NSDictionary *dic = _tableArr[indexPath.row];
        cell.textLabel.font = FONT(15);
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = dic[@"image"];
        cell.detailTextLabel.font = FONT(13);
        cell.detailTextLabel.text = dic[@"text"];
    }
    else if (indexPath.section == 1){
        
        NSDictionary *dic = _tableArr2[indexPath.row];
        cell.textLabel.font = FONT(15);
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = dic[@"image"];
        cell.detailTextLabel.font = FONT(13);
        cell.detailTextLabel.text = dic[@"text"];
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}



@end
