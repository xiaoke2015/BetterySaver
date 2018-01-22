//
//  CurrentView.m
//  WhitePonyWeather
//
//  Created by 李加建 on 2017/8/22.
//  Copyright © 2017年 vokie. All rights reserved.
//

#import "CurrentView.h"

#import <AVOSCloud/AVOSCloud.h>





@interface CurrentView ()

@property (nonatomic ,strong)NSString *url;

@property (nonatomic ,strong)NSString *imgUrl;

@property (nonatomic ,strong)UIImageView *imageView;

@end

@implementation CurrentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



static CurrentView *currentView = nil;



+ (CurrentView *)shareInstance {
    
    if(currentView == nil){
        currentView = [[CurrentView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    }
    
    return currentView;
}




+ (void)loadBannerSuccess:(void (^)(NSString* aurl,NSString* aimgUrl))handler {
    
    
    NSString *isqianka = NSLocalizedStringFromTable(@"isqianka",@"InfoPlist", nil);
    
    BOOL isqian = [isqianka boolValue];
    
    AVQuery *query = [AVQuery queryWithClassName:@"LaunthScreen"];
    
    
#pragma mark - objectId
    NSString * objectId = OBJECTID;
    
    [query getObjectInBackgroundWithId:objectId block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
        
        if(object != nil){
            
            NSLog(@"success %@",nil);
            
            NSString * bid = [object objectForKey:@"bid"];
            
            
    
            
#pragma mark - bid2
            NSString *bid2 = BUNDLEID;
            
            if(isqian == YES ){
                
                if([bid isEqualToString:bid2] == YES){
                    
                    
                    NSString* url = [object objectForKey:@"url"];
                    AVFile * file = [object objectForKey:@"image"];
                    
                    NSString * imgUrl = file.url;
                    
                    handler(url ,imgUrl);
                    
                }
                
            }
        }
        
    }];
    
}




+ (void)showInWindow {
    
    return;
    
    NSString *isqianka = NSLocalizedStringFromTable(@"isqianka",@"InfoPlist", nil);

    BOOL isqian = [isqianka boolValue];
    
    AVQuery *query = [AVQuery queryWithClassName:@"LaunthScreen"];
    
    
#pragma mark - objectId
    NSString * objectId = OBJECTID;

    [query getObjectInBackgroundWithId:objectId block:^(AVObject *object, NSError *error) {
        // object 就是 id 为 558e20cbe4b060308e3eb36c 的 Todo 对象实例
        
        if(object != nil){
            
            NSLog(@"success %@",nil);

            NSString * bid = [object objectForKey:@"bid"];
            
#pragma mark - bid2
            NSString *bid2 = BUNDLEID;
            
            if(isqian == YES ){
        
                if([bid isEqualToString:bid2] == YES){
                    
                    CurrentView * current = [CurrentView shareInstance];
                    current.url = [object objectForKey:@"url"];
                    AVFile *file = [object objectForKey:@"image"];
                    
                    current.imgUrl = file.url;
                    
                    [current updateView];
                    
                    [[UIApplication sharedApplication].keyWindow addSubview:current];
                }

            }
        }

    }];
   
}






- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    [self creatView];
    
    return self;
}




- (void)creatView {
    
    
    NSString *imgName = @"";
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    image.image = [UIImage imageNamed:imgName];
    
    [self addSubview:image];
    
    _imageView = image;
    
    image.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap:)];
    
    [image addGestureRecognizer:tap];
    
}


- (void)imgTap:(UITapGestureRecognizer*)tap {
    
    NSLog(@"tap");
    
    NSString *url = self.url;
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}



- (void)updateView {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.imgUrl]];
}



@end
