//
//  ViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/24.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ViewController.h"

#define pi 3.14159265359
#define DEGREES_TO_RADIANS(degress) ((pi * degress)/180)


#import "VWWWaterView.h"

#import "AppInfo.h"

#import "MonitorIOS.h"

#import "CircularProgressView.h"

#import "StorageViewController.h"
#import "CPUUsedViewController.h"
#import "BatteryViewController.h"

@interface ViewController ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CAShapeLayer *shapeLayer2;

@property (nonatomic,strong) VWWWaterView *waterView;

@property (nonatomic ,strong)NSArray * homeArray;

@property (nonatomic ,strong)NSMutableArray * btnArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    self.navigationController.navigationBarHidden = YES;
 
//    [self creatView];
//    self.view.backgroundColor = [UIColor orangeColor];
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 375, 667)];
    image.image = [UIImage imageNamed:@"background_date"];
    [self.view addSubview:image];
    
 
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)RGB(10, 22, 58).CGColor,
//                             (__bridge id)RGB(57, 103, 132).CGColor,
//                             (__bridge id)RGB(10, 22, 58).CGColor];
//    gradientLayer.locations = @[@0.3, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = CGRectMake(0, 0, 375, 667);
//    [self.view.layer addSublayer:gradientLayer];
    
 
    
    CGFloat hhh = 180;
    
    VWWWaterView *waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - hhh/2, 100, hhh, hhh)];
    waterView.backgroundColor = [UIColor redColor];
    [self.view addSubview:waterView];
    waterView.layer.masksToBounds = YES;
    waterView.layer.cornerRadius = waterView.height/2;
    
    _waterView = waterView;
    
    [self initData];
    
    [self creatView2];
    
//    [self creatView];
    
    MonitorIOS * monitor = [[MonitorIOS alloc]init];
    
    [monitor systemStats];
    

    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDictionary *fat = [fm attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    NSLog(@"容量：%.2f G 可用容量：%.2f G",[[fat objectForKey:NSFileSystemSize]longLongValue]/1000000000.f,[[fat objectForKey:NSFileSystemFreeSize]longLongValue]/1000000000.f);
    
    
    
    CircularProgressView *progressView = [[CircularProgressView alloc]initWithFrame:CGRectMake(0, 100, 180, 180)];
    
    [progressView setCurrentColor:RGB(255, 150, 22)];
    
    [self.view addSubview:progressView];
    
    [progressView showAnmiDuration:1.0 from:0 to:0.66];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)creatView {
    
    CALayer *testLayer = [CALayer layer];
    testLayer.backgroundColor = [UIColor clearColor].CGColor;
    testLayer.frame = CGRectMake(100, 300, 100, 100);
    [self.view.layer addSublayer:testLayer];
    
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = RGB(255, 255, 255).CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineWidth = 7;
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50-3.5 startAngle:0 endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    _shapeLayer.path = thePath.CGPath;
    [testLayer addSublayer:_shapeLayer];
    
    
    _shapeLayer2 = [CAShapeLayer layer];
    _shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer2.strokeColor = RGB(20, 150, 26).CGColor;
    _shapeLayer2.lineCap = kCALineCapRound;
    _shapeLayer2.lineWidth = 7;
    
    
    CGFloat endAngle = -M_PI_2 + M_PI *2 *0.8;
    
    UIBezierPath *thePath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(50, 50) radius:50-3.5 startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
    _shapeLayer2.path = thePath2.CGPath;
    [testLayer addSublayer:_shapeLayer2];
    
    
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    animation.keyPath = @"transform.rotation.z";
//    animation.duration = 4.f;
//    animation.fromValue = @(0);
//    animation.toValue = @(2*M_PI);
//    animation.repeatCount = INFINITY;
//    
//    [testLayer addAnimation:animation forKey:nil];
    
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.5f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.shapeLayer2 addAnimation:pathAnimation forKey:nil];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static CGFloat i = 0.2;
    
    i = i+0.1;
    
    [_waterView startWave:i];
}







- (void)initData {
    
    
    _homeArray = @[
                   @{@"image":@"Length",@"text":@"Device"},
                   @{@"image":@"Area",@"text":@"Memory"},
                   @{@"image":@"Volume",@"text":@"Storage"},
                   @{@"image":@"Power",@"text":@"Network"},
                   @{@"image":@"Pressure",@"text":@"Pressure"},
                   @{@"image":@"Stroge",@"text":@"Battery"}
  
                   ];
}



- (void)creatView2 {
    
    
    CGFloat hhh = 504/750.f * SCREEM_WIDTH;
    
    CGFloat y2 = SCREEM_HEIGHT - hhh - 64;
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    
    
    CGFloat x1 = 8;
    CGFloat x2 = 8;
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - x1*2 - x2*2)/3;
    
    CGFloat y1 = (SCREEM_HEIGHT - (w+x2)*2 - x2);
    
    _btnArray = [NSMutableArray array];
    
    
    for(int i = 0;i<_homeArray.count;i++){
        
        x = x1 + (w + x2)*(i%3);
        y = y1 + (w + x2)*(i/3);
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, w)];
        
        [self.view addSubview:btn];
        
        NSDictionary *dic = _homeArray[i];
        
        [btn setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:dic[@"image"]] forState:UIControlStateHighlighted];
        
        [btn setTitle:dic[@"text"] forState:UIControlStateNormal];
        btn.backgroundColor = RGBA(255, 255, 255, 0.1);
        
        
        
        //设置文字偏移：向下偏移图片高度＋向左偏移图片宽度 （偏移量是根据［图片］大小来的，这点是关键）
        btn.titleEdgeInsets = UIEdgeInsetsMake(btn.imageView.frame.size.height, -btn.imageView.frame.size.width, 0, 0);
        //设置图片偏移：向上偏移文字高度＋向右偏移文字宽度 （偏移量是根据［文字］大小来的，这点是关键）
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(-btn.titleLabel.bounds.size.height, 0, 0, -btn.titleLabel.bounds.size.width);
        
//        btn.layer.masksToBounds = YES;
//        btn.layer.cornerRadius = 4;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = RGBA(255, 255, 255, 0.3).CGColor;
        
        
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_btnArray addObject:btn];
        
    }
    
}




- (void)btnAction:(UIButton*)btn {
    
    NSInteger tag = [_btnArray indexOfObject:btn];
    
    NSDictionary *dict = _homeArray[tag];
    
    if(tag == 0){
        
        StorageViewController *nextVC = [[StorageViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 1){
        
        CPUUsedViewController *nextVC = [[CPUUsedViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 2){
        
        BatteryViewController *nextVC = [[BatteryViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 3){
        
        CPUUsedViewController *nextVC = [[CPUUsedViewController alloc]init];
        [self.navigationController pushViewController:nextVC animated:YES];
    }
 
}




@end
