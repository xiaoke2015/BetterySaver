//
//  VWWWaterView.h
//  Water Waves
//
//  Created by Veari_mac02 on 14-5-23.
//  Copyright (c) 2014年 Veari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VWWWaterView : UIView

@property (nonatomic,strong) UILabel *textLabel;

@property (nonatomic,strong) UILabel *detailLabel;


- (void)startWave:(CGFloat) scale ;

@end
