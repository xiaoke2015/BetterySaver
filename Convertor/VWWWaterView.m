//
//  VWWWaterView.m
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import "VWWWaterView.h"


#define ForegroundColor [UIColor colorWithRed:11/255.0f green:186/255.0f blue:137/255.0f alpha:1]
#define BackgroundColor [UIColor colorWithRed:11/255.0f green:186/255.0f blue:137/255.0f alpha:0.5]
@interface VWWWaterView ()
{
    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    float _currentWidth;
    
    float a;
    float b;
    
    BOOL jia;
}


@property (nonatomic ,strong)NSTimer * timer;

@end


@implementation VWWWaterView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        a = 1.5;
        b = 0;
        jia = NO;
        
        [self creatView];
        
        _currentWaterColor = ForegroundColor;
        _currentWidth = self.width;
        
        [self startWave:0.2];
        
    }
    return self;
}



- (void)creatView {
    
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


- (void)startWave:(CGFloat) scale {
    
    _currentLinePointY = self.height * (1 - scale);
    
    [_timer invalidate];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
}



- (void)animateWave {
    
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    [self water1:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    
    for(float x=0;x<=_currentWidth;x++){
        
        y= a * sin( x/180*M_PI + 4*b/M_PI ) * 5 + _currentLinePointY;
        
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _currentWidth, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);


}


- (void)water1:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [BackgroundColor CGColor]);
    
    float y=_currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    
    for(float x=0;x<=_currentWidth;x++){
        
        y= a * sin( x/90*M_PI + 4*b/M_PI ) * 10 + _currentLinePointY;
        
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _currentWidth, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    

}


@end
