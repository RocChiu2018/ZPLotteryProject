//
//  ZPCollectionViewCell.m
//  彩票项目
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPCollectionViewCell.h"
#import "ZPAPP.h"

@interface ZPCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation ZPCollectionViewCell

- (void)awakeFromNib
{
    self.iconImageView.layer.cornerRadius = 8;  //设置图标的圆角
    self.iconImageView.clipsToBounds = YES;  //超出圆角的都剪切掉
}

- (void)setApp:(ZPAPP *)app
{
    _app = app;
    
    //设置图片
    self.iconImageView.image = [UIImage imageNamed:app.icon];
    
    //设置名称
    self.nameLabel.text = app.title;
}

@end
