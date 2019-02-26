//
//  ZPScoreLiveRemindViewController.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPScoreLiveRemindViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingGroup.h"
#import "ZPSettingLabelItem.h"

@interface ZPScoreLiveRemindViewController ()

@end

@implementation ZPScoreLiveRemindViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupGroup];
    [self setupGroup1];
    [self setupGroup2];
}

#pragma mark ————— 设置第0组数据 —————
- (void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingSwitchItem *concernedGameItem = [ZPSettingSwitchItem itemWithTitle:@"提醒我关注的比赛"];
    group.itemsArray = [NSArray arrayWithObjects:concernedGameItem, nil];
    
    group.header = @"提醒我关注的比赛";
    group.footer = @"提醒我关注的比赛";
    
    [self.mutableArray addObject:group];
}

#pragma mark ————— 设置第1组数据 —————
- (void)setupGroup1
{
    ZPSettingGroup *group1 = [[ZPSettingGroup alloc] init];
    
    ZPSettingLabelItem *startTimeItem = [ZPSettingLabelItem itemWithTitle:@"起始时间"];
    group1.itemsArray = [NSArray arrayWithObjects:startTimeItem, nil];
    
    group1.header = @"起始时间";
    group1.footer = @"起始时间";
    
    [self.mutableArray addObject:group1];
}

#pragma mark ————— 设置第2组数据 —————
- (void)setupGroup2
{
    ZPSettingGroup *group2 = [[ZPSettingGroup alloc] init];
    
    ZPSettingLabelItem *endTimeItem = [ZPSettingLabelItem itemWithTitle:@"结束时间"];
    group2.itemsArray = [NSArray arrayWithObjects:endTimeItem, nil];
    
    group2.header = @"结束时间";
    group2.footer = @"结束时间";
    
    [self.mutableArray addObject:group2];
}

@end
