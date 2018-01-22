//
//  CircularProgressView.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "CircularProgressView.h"


@interface CircularProgressView ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,strong) CAShapeLayer *shapeForegroundLayer;

@property (nonatomic,strong) CALayer *testLayer;
@property (nonatomic,strong) CALayer *roundLayer;




@end

@implementation CircularProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.lineWidth = 5;
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    CALayer *testLayer = [CALayer layer];
    testLayer.backgroundColor = [UIColor clearColor].CGColor;
    testLayer.frame = CGRectMake(0, 0, self.width, self.height);
    [self.layer addSublayer:testLayer];
    
    self.testLayer = testLayer;
    
    // 背景layer
    _shapeLayer = [CAShapeLayer layer];
    _shapeLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeLayer.strokeColor = RGB(255, 255, 255).CGColor;
    _shapeLayer.lineCap = kCALineCapRound;
    _shapeLayer.lineWidth = self.lineWidth;
    
    // 圆环半径
    CGFloat radius = self.width/2 - self.lineWidth/2;
    
    // 圆环中心点
    CGPoint center = CGPointMake(self.width/2, self.height/2);
    
    UIBezierPath *thePath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle: M_PI * 2 clockwise:YES];
    _shapeLayer.path = thePath.CGPath;
    [testLayer addSublayer:_shapeLayer];
    
    
    // 显示 layer
    _shapeForegroundLayer = [CAShapeLayer layer];
    _shapeForegroundLayer.fillColor = [UIColor clearColor].CGColor;
    _shapeForegroundLayer.strokeColor = RGB(0, 176, 85).CGColor;
    _shapeForegroundLayer.lineCap = kCALineCapRound;
    _shapeForegroundLayer.lineWidth = self.lineWidth;
    
    
    CGFloat endAngle = -M_PI_2 + M_PI * 2;
    
    UIBezierPath *thePath2 = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:endAngle clockwise:YES];
    _shapeForegroundLayer.path = thePath2.CGPath;
    [testLayer addSublayer:_shapeForegroundLayer];
    
    
    //背景圆环
    CGFloat roundRadius = self.lineWidth + 15;
    CALayer *roundLayer = [CALayer layer];
    roundLayer.backgroundColor = [UIColor whiteColor].CGColor;
    roundLayer.frame = CGRectMake(roundRadius/2, roundRadius/2, self.width - roundRadius, self.height - roundRadius);
    [self.layer addSublayer:roundLayer];
    roundLayer.masksToBounds = YES;
    roundLayer.cornerRadius = (self.width - roundRadius)/2;
    
    self.roundLayer = roundLayer;
    
    
    _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3 - 15, self.width, self.height/3)];
    
    _textLabel.font = [UIFont fontWithName:@"arial" size:55];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.textColor = [UIColor whiteColor];

    [self addSubview:_textLabel];
    
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height/3*2, self.width, 20)];
    
    _detailLabel.font = [UIFont fontWithName:@"arial" size:16];
    _detailLabel.textAlignment = NSTextAlignmentCenter;
    _detailLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:_detailLabel];
}




- (void)setCurrentColor:(UIColor*)color {
    
    self.roundLayer.backgroundColor = color.CGColor;
    _shapeForegroundLayer.strokeColor = color.CGColor;

}






#pragma  展示动画
- (void)showAnmiDuration:(CFTimeInterval)duration from:(CGFloat)fromValue  to:(CGFloat)toValue {
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.repeatCount = 0;
    pathAnimation.duration = duration;
    pathAnimation.fromValue = [NSNumber numberWithFloat:fromValue];
    pathAnimation.toValue = [NSNumber numberWithFloat:toValue];
    
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    //防止动画结束后回到初始状态
    pathAnimation.removedOnCompletion = NO;
    pathAnimation.fillMode = kCAFillModeForwards;
    
    [self.shapeForegroundLayer addAnimation:pathAnimation forKey:nil];
    
    
    if(_title == nil){
        
        _textLabel.text = [NSString stringWithFormat:@"%ld%%",(NSInteger)(toValue *100)];
    }
    else {
        _textLabel.text = _title;
    }
    
}

@end
