//
//  MoreViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/30.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MoreViewController.h"

#import "FeedBackViewController.h"

@interface MoreViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Settings"];
    
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
    
    _tableArr =  @[
                   @{@"image":@"1",@"text":@"Comment"},
                   @{@"image":@"3",@"text":@"Feedback"},
                   @{@"image":@"2",@"text":@"Share"},
                   ];
    
}


- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64  - 0)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = [UIColor whiteColor];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _tableArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    
    NSDictionary *dict = _tableArr[indexPath.row];
    
    NSString *name = dict[@"text"];
    
    cell.textLabel.text = name;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *dict = _tableArr[indexPath.row];
    
    NSInteger tag = [dict[@"image"] integerValue];
    
    if(tag == 1){
        [self commentAction];
    }
    else if(tag == 2){
        
        [self shareAction];
    }
    else if(tag == 3){
        
        
        FeedBackViewController *nextVC = [[FeedBackViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if(tag == 4){
    }
}




- (void)commentAction {
    
    NSString *url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=";
    
    url = [url stringByAppendingString:APPSTOREID];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
    
}


- (void)shareAction {
    
    
    NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPSTOREID];
    
    NSString *share_title = @"分享给你";
    NSString *share_url = string;
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
    
}



- (void)feekBack {
    
    
    
}







@end
