//
//  ZPWinningAnimationViewController.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPWinningAnimationViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingGroup.h"

@interface ZPWinningAnimationViewController ()

@end

@implementation ZPWinningAnimationViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupGroup];
}

#pragma mark ————— 设置数据 —————
- (void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingSwitchItem *winningAnimationItem = [ZPSettingSwitchItem itemWithTitle:@"中奖动画"];
    group.itemsArray = [NSArray arrayWithObjects:winningAnimationItem, nil];
    
    group.header = @"中奖动画";
    group.footer = @"中奖动画";
    
    [self.mutableArray addObject:group];
}

@end
