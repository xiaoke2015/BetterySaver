//
//  HomeTableViewCell.m
//  Convertor
//
//  Created by 李加建 on 2017/8/28.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = NO;
    
    [self creatView];
    
    return self;
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(15, self.height/2 - 15, 0, 0);
    
    _iconBtn.frame = CGRectMake(15, self.height/2 - 20, 40, 40);
    
    self.textLabel.frame = CGRectMake(70, self.height/2 - 15, SCREEM_WIDTH - 80, 30);
}


- (void)creatView {
    
    self.backgroundColor = RGB(50, 50, 50);
    self.contentView.backgroundColor = RGB(50, 50, 50);
   
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    image.image = [UIImage imageNamed:@"arrow_right"];
    
    self.accessoryView = image;
    
    
    _iconBtn = [[UIButton alloc]init];
    _iconBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_iconBtn];
    
}


@end
