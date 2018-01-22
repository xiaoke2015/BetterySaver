//
//  CircularProgressView.h
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView

@property (nonatomic ,assign)CGFloat lineWidth;
@property (nonatomic ,strong)UIColor *currentColor;

@property (nonatomic,strong) UILabel *textLabel;

@property (nonatomic,strong) UILabel *detailLabel;

@property (nonatomic,strong) NSString *title;


- (void)showAnmiDuration:(CFTimeInterval)duration from:(CGFloat)fromValue  to:(CGFloat)toValue ;

@end
