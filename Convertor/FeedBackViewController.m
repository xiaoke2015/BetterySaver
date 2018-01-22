//
//  FeedBackViewController.m
//  Convertor
//
//  Created by 李加建 on 2017/8/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "FeedBackViewController.h"

#import "MLTextView.h"

#import <AVOSCloud/AVOSCloud.h>

@interface FeedBackViewController ()<UIAlertViewDelegate>

@property (nonatomic ,strong)MLTextView *textView ;


@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"Feedback"];
    
    [self creatView];
    
    [self initRightItem];
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





- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];

    [btn setTitle:@"Send" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT(15);
    
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius = 35/2.f;
//    btn.backgroundColor = [UIColor whiteColor];
    
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
  
    
}


- (void)rightItemAction {
    
    
    NSString *text = _textView.textView.text;
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"Feedback"];// 构建对象
    [todoFolder setObject:text forKey:@"content"];// 设置名称
    [todoFolder setObject:@1 forKey:@"priority"];// 设置优先级
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        NSLog(@"success");
        
        if(succeeded == YES){
            
            [self alertWithText:@"Feedback success"];
        }
        else {
            [self alertWithText:@"Feedback error"];
        }
        
        
    }];// 保存到云端
}



- (void)creatView {
    
    _textView = [[MLTextView alloc]initWithFrame:CGRectMake(20, 20, SCREEM_WIDTH - 40, 150)];
    _textView.placeholder.text = @"content";
    [self.view addSubview:_textView];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 1;
    _textView.layer.borderColor = RGB(240, 240, 240).CGColor;
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
//    [self.view endEditing:YES];
    [_textView.textView resignFirstResponder];
}



- (void)alertWithText:(NSString*)text {
    
//    [self.view endEditing:YES];
    [_textView.textView resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:text message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [alert show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
