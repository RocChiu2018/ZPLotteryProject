//
//  ZPLotteryNumberPushViewController.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPLotteryNumberPushViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingGroup.h"

@interface ZPLotteryNumberPushViewController ()

@end

@implementation ZPLotteryNumberPushViewController

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
    
    ZPSettingSwitchItem *doubleChromosphereItem = [ZPSettingSwitchItem itemWithTitle:@"双色球"];
    ZPSettingSwitchItem *bigLottoItem = [ZPSettingSwitchItem itemWithTitle:@"大乐透"];
    group.itemsArray = [NSArray arrayWithObjects:doubleChromosphereItem, bigLottoItem, nil];
    
    group.header = @"双色球";
    group.footer = @"大乐透";
    
    [self.mutableArray addObject:group];
}

@end
