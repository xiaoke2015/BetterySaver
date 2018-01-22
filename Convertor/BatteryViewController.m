//
//  BatteryViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BatteryViewController.h"

#import "VWWWaterView.h"

@interface BatteryViewController ()

@property (nonatomic,strong) VWWWaterView *waterView;


@end

@implementation BatteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Battery"];
    //    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = RGB(50, 50, 50);
    
//    [self initBackBtn];
    
    [self creatView];
    
    [self creatBtn];
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



- (void)creatBtn {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2-50, SCREEM_HEIGHT - 64 - 60, 100, 30)];
    
    btn.backgroundColor = RGB(11, 186, 137);
    [btn setTitle:@"view details" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(12);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.height/2;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction {
    
    NSString *path = [NSString stringWithFormat:@"prefs:root=NOTIFICATIONS_ID&path=%@",BUNDLEID];
    
    NSURL*url = [NSURL URLWithString:path];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}


- (void)creatView {
    
    CGFloat hhh = 240;
    
    
    
    CALayer *testLayer = [CALayer layer];
    testLayer.backgroundColor = RGB(25, 25, 25).CGColor;
    testLayer.frame = CGRectMake(SCREEM_WIDTH/2 - hhh/2, 60, hhh, hhh);
    [self.view.layer addSublayer:testLayer];
    
    testLayer.masksToBounds = YES;
    testLayer.cornerRadius = hhh/2;
    
    
    // 背景layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = RGB(255, 255, 255).CGColor;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineWidth = 5;
    
    // 圆环半径
    CGFloat radius = hhh/2 - 2.5;
    
    // 圆环中心点
    CGPoint center = CGPointMake(hhh/2, hhh/2);
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle: M_PI * 2 clockwise:YES];
    shapeLayer.path = thePath.CGPath;
//    [testLayer addSublayer:shapeLayer];
    
    CGFloat ww = hhh - 20;
    
    VWWWaterView *waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - ww/2,  60+10, ww, ww)];
//    waterView.backgroundColor = [UIColor redColor];
    [self.view addSubview:waterView];
    waterView.layer.masksToBounds = YES;
    waterView.layer.cornerRadius = waterView.height/2;
    
//    [waterView startWave:0.3];
    
    self.waterView = waterView;
    
    
    UIDevice *device = [UIDevice currentDevice];
    device.batteryMonitoringEnabled = YES;
    
    [self batteryStateDidChange];
    
    //监视电池剩余电量
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action1:) name:UIDeviceBatteryLevelDidChangeNotification object:nil];
    
    //监视充电状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(action2:) name:UIDeviceBatteryStateDidChangeNotification object:nil];

}


- (void)action1:(NSNotification*)notification {
    
    [self batteryStateDidChange];

}

- (void)action2:(NSNotification*)notification {
 
    [self batteryStateDidChange];
}



- (void)batteryStateDidChange {
    
    VWWWaterView *waterView = self.waterView;
    
    UIDevice *device = [UIDevice currentDevice];
//    device.batteryMonitoringEnabled = YES;
    
    CGFloat  batteryLevel =  device.batteryLevel;
    NSLog(@"batteryLevel = %.2f",batteryLevel);
    
    if(batteryLevel >=0){
        
        [waterView startWave:batteryLevel];
        
        waterView.textLabel.text = [NSString stringWithFormat:@"%.f%%",batteryLevel*100];
    }
    else {
        [waterView startWave:1.0];
        waterView.textLabel.text = [NSString stringWithFormat:@"%.f%%",1.f*100];

    }
    
    
    UIDeviceBatteryState  batteryState =  device.batteryState;
    
    if(batteryState == UIDeviceBatteryStateUnplugged){
        //未充电
        waterView.detailLabel.text = [NSString stringWithFormat:@"uncharged"];
    }
    else if(batteryState == UIDeviceBatteryStateCharging){
        //充电中
        waterView.detailLabel.text = [NSString stringWithFormat:@"Charging"];
    }
    else if(batteryState == UIDeviceBatteryStateFull){
        //满电量
        waterView.detailLabel.text = [NSString stringWithFormat:@"Full power"];
    }
    else {
        waterView.detailLabel.text = [NSString stringWithFormat:@"Full power"];

    }

}

@end
