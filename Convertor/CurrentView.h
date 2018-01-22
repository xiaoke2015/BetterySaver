//
//  CurrentView.h
//  WhitePonyWeather
//
//  Created by 李加建 on 2017/8/22.
//  Copyright © 2017年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIImageView+WebCache.h>

@interface CurrentView : UIView

+ (void)showInWindow ;


+ (void)loadBannerSuccess:(void (^)(NSString* aurl,NSString* aimgUrl))handler  ;

@end
