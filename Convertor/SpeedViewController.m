//
//  SpeedViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//



#import "SpeedViewController.h"

#import "MeasurNetTools.h"

#import "CircularProgressView.h"

@interface SpeedViewController ()

@property (nonatomic ,strong)CircularProgressView *progressView;

@property (nonatomic ,strong)UILabel *label;
@property (nonatomic ,strong)UILabel *label2;

@property (nonatomic ,strong)UIButton *startBtn;

@end

@implementation SpeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(50, 50, 50);
    
    [self initNaviBarBtn:@"Net Speed"];
    
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



- (void)creatView {
    
    CircularProgressView *progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 120, 60, 240, 240)];
    
    [progressView setCurrentColor:RGB(240, 37, 1)];
    
    [self.view addSubview:progressView];
    
    self.progressView = progressView;
    
//    [progressView showAnmiDuration:1.0 from:0 to:scale];
    
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:progressView.frame];
    
    [btn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.height/2;
    
    self.startBtn = btn;

    [self.progressView showAnmiDuration:0 from:0 to:0];

    self.progressView.textLabel.text = @"Start";
    self.progressView.title = @"Start";
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 340, SCREEM_WIDTH, 20)];
    
//    label.text = [NSString stringWithFormat:@"Used: %.2f GB",all - Avai];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 370, SCREEM_WIDTH, 20)];
    
//    label2.text = [NSString stringWithFormat:@"Available: %.2f GB",Avai];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = [UIColor whiteColor];
    [self.view addSubview:label2];
    
    self.label = label;
    self.label2 = label2;

}



- (void)startAction {
    
    
    [self.progressView showAnmiDuration:15 from:0 to:1];
    self.startBtn.userInteractionEnabled = NO;
    
    MeasurNetTools * meaurNet = [[MeasurNetTools alloc] initWithblock:^(float speed) {
        NSString* speedStr = [NSString stringWithFormat:@"%@/S", [QBTools formattedFileSize:speed]];
        NSLog(@"即时速度:speed:%@",speedStr);
        
        self.progressView.detailLabel.text = speedStr;
        
    } finishMeasureBlock:^(float speed) {
        NSString* speedStr = [NSString stringWithFormat:@"%@/S", [QBTools formattedFileSize:speed]];
        NSString *band = [QBTools formatBandWidth:speed];
        NSLog(@"平均速度为：%@",speedStr);
        NSLog(@"相当于带宽：%@",band);
        
        self.label.text = [NSString stringWithFormat:@"Average Speed: %@",speedStr];
        self.label2.text = [NSString stringWithFormat:@"Bandwidth: %@",band];
        self.startBtn.userInteractionEnabled = YES;
        
    } failedBlock:^(NSError *error) {
        
        self.startBtn.userInteractionEnabled = YES;
    }];
    
    [meaurNet startMeasur];
}


@end
