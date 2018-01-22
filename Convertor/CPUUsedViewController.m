//
//  CPUUsedViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CPUUsedViewController.h"

#import "CircularProgressView.h"

#import "MonitorIOS.h"

@interface CPUUsedViewController ()

@end

@implementation CPUUsedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"CPU Usage"];
    //    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGB(50, 50, 50);
    
//    [self initBackBtn];
    
    [self creatView];
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
    

    CGFloat scale = [MonitorIOS systemCPUPercent]/100;
    
    CircularProgressView *progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 120, 60, 240, 240)];
    
    [progressView setCurrentColor:RGB(0, 176, 85)];
    
    [self.view addSubview:progressView];
    
    [progressView showAnmiDuration:1.0 from:0 to:scale];
    
    
    progressView.detailLabel.text = [NSString stringWithFormat:@"CPU Usage"];
    
    
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 400, SCREEM_WIDTH, 20)];
//    
//    label.text = [NSString stringWithFormat:@"Used: %.2f GB",all - Avai];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor whiteColor];
//    [self.view addSubview:label];
//    
//    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 430, SCREEM_WIDTH, 20)];
//    
//    label2.text = [NSString stringWithFormat:@"Available: %.2f GB",Avai];
//    label2.textAlignment = NSTextAlignmentCenter;
//    label2.textColor = [UIColor whiteColor];
//    [self.view addSubview:label2];
    
}




@end
