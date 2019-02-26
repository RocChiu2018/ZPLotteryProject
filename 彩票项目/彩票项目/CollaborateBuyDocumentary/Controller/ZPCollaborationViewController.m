//
//  ZPCollaborationViewController.m
//  彩票项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPCollaborationViewController.h"
#import "ZPPulldownButton.h"

@interface ZPCollaborationViewController ()

@end

@implementation ZPCollaborationViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ————— 点击“全部彩种”按钮 —————
- (IBAction)titleButtonClick:(ZPPulldownButton *)sender
{
    //黄色三角旋转180度
    [UIView animateWithDuration:0.25 animations:^{
        //只想让按钮的图片（三角形）进行旋转，所以写为sender.imageView
        sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

@end
