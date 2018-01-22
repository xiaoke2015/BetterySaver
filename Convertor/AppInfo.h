//
//  AppInfo.h
//  QKDM001
//
//  Created by 李加建 on 2017/8/25.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppInfo : NSObject

@property (nonatomic ,strong)NSString * TotalMemory;
@property (nonatomic ,strong)NSString * WiredMemory;
@property (nonatomic ,strong)NSString * ActiveMemory;
@property (nonatomic ,strong)NSString * InactiveMemory;
@property (nonatomic ,strong)NSString * FreeMemory;
@property (nonatomic ,strong)NSString * UsedMemory;
@property (nonatomic ,assign)CGFloat scaleMemory;


+ (NSString *)iPhoneName ;



+ (NSString *)carrierName ;


+ (NSString*)getCurrentLocalIP ;

+ (NSString *)getCurreWiFiName ;

+ (NSString *)getCurreBSSID ;





- (void)GetMemoryStatistics ;

@end
