//
//  ZPSettingTableViewController.m
//  彩票项目
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPPushAndRemindTableViewController.h"
#import "ZPSettingGroup.h"
#import "ZPSettingTableViewCell.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingItem.h"
#import "MBProgressHUD+MJ.h"
#import "ZPCollectionViewController.h"
#import "ZPPushAndRemindTableViewController.h"
#import "ZPLotteryNumberPushViewController.h"
#import "ZPWinningAnimationViewController.h"
#import "ZPScoreLiveRemindViewController.h"
#import "ZPBuyLotteryRegularlyRemindedViewController.h"

@interface ZPPushAndRemindTableViewController ()

@end

@implementation ZPPushAndRemindTableViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupGroup];
}

#pragma mark ————— 设置数据 —————
-(void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingArrowItem *lotteryNumberPushItem = [ZPSettingArrowItem itemWithTitle:@"开奖号码推送" vcClass:[ZPLotteryNumberPushViewController class]];
    ZPSettingArrowItem *winningAnimationItem = [ZPSettingArrowItem itemWithTitle:@"中奖动画" vcClass:[ZPWinningAnimationViewController class]];
    ZPSettingArrowItem *scoreLiveRemindItem = [ZPSettingArrowItem itemWithTitle:@"比分直播提醒" vcClass:[ZPScoreLiveRemindViewController class]];
    ZPSettingArrowItem *buyLotteryRegularlyRemindedItem = [ZPSettingArrowItem itemWithTitle:@"购彩定时提醒" vcClass:[ZPBuyLotteryRegularlyRemindedViewController class]];
    group.itemsArray = [NSArray arrayWithObjects:lotteryNumberPushItem, winningAnimationItem, scoreLiveRemindItem, buyLotteryRegularlyRemindedItem, nil];
    
    [self.mutableArray addObject:group];
}

@end
