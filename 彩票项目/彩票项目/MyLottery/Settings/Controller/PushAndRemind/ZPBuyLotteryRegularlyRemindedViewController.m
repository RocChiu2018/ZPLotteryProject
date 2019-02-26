//
//  ZPBuyLotteryRegularlyRemindedViewController.m
//  彩票项目
//
//  Created by 赵鹏 on 2019/2/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ZPBuyLotteryRegularlyRemindedViewController.h"
#import "ZPSettingGroup.h"
#import "ZPSettingSwitchItem.h"

@interface ZPBuyLotteryRegularlyRemindedViewController ()

@end

@implementation ZPBuyLotteryRegularlyRemindedViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup];
}

#pragma mark ————— 设置数据 —————
- (void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingSwitchItem *buyLotteryRegularlyRemindedItem = [ZPSettingSwitchItem itemWithTitle:@"购彩定时提醒"];
    group.itemsArray = [NSArray arrayWithObjects:buyLotteryRegularlyRemindedItem, nil];
    
    group.header = @"购彩定时提醒";
    group.footer = @"购彩定时提醒";
    
    [self.mutableArray addObject:group];
}

@end
