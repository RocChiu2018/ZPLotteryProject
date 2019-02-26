//
//  ZPSettingTableViewController.m
//  彩票项目
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPSettingTableViewController.h"
#import "ZPExamineMessageViewController.h"
#import "ZPSettingGroup.h"
#import "ZPSettingTableViewCell.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingItem.h"
#import "MBProgressHUD+MJ.h"
#import "ZPCollectionViewController.h"
#import "ZPPushAndRemindTableViewController.h"
#import "ZPHelpViewController.h"
#import "ZPShareViewController.h"
#import "ZPAboutViewController.h"

@interface ZPSettingTableViewController ()

@end

@implementation ZPSettingTableViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self setupGroup];
    [self setupGroup1];
}

#pragma mark ————— 设置第0组数据 —————
-(void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingArrowItem *pushRemindItem = [ZPSettingArrowItem itemWithIcon:@"MorePush" title:@"推送和提醒" vcClass:[ZPPushAndRemindTableViewController class]];
    ZPSettingSwitchItem *handShakeItem = [ZPSettingSwitchItem itemWithIcon:@"handShake" title:@"摇一摇机选"];
    ZPSettingSwitchItem *soundEffectsItem = [ZPSettingSwitchItem itemWithIcon:@"sound_Effect" title:@"声音效果"];
    group.itemsArray = [NSArray arrayWithObjects:pushRemindItem, handShakeItem, soundEffectsItem, nil];
    
    group.header = @"头部";
    group.footer = @"尾部";
    
    [self.mutableArray addObject:group];
}

#pragma mark ————— 设置第1组数据 —————
-(void)setupGroup1
{
    ZPSettingGroup *group1 = [[ZPSettingGroup alloc] init];
    
    ZPSettingArrowItem *updateItem = [ZPSettingArrowItem itemWithIcon:@"MoreUpdate" title:@"检查新版本" vcClass:nil];
    updateItem.option = ^{
        
        [MBProgressHUD showMessage:@"正在检查中..."];  //弹出提示框
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUD];  //移除HUD
            [MBProgressHUD showError:@"没有新版本"];
        });
    };
    ZPSettingArrowItem *helpItem = [ZPSettingArrowItem itemWithIcon:@"MoreHelp" title:@"帮助" vcClass:[ZPHelpViewController class]];
    ZPSettingArrowItem *shareItem = [ZPSettingArrowItem itemWithIcon:@"MoreShare" title:@"分享" vcClass:[ZPShareViewController class]];
    ZPSettingArrowItem *examineMsgItem = [ZPSettingArrowItem itemWithIcon:@"MoreMessage" title:@"查看消息" vcClass:[ZPExamineMessageViewController class]];
    ZPSettingArrowItem *productRecommendationsItem = [ZPSettingArrowItem itemWithIcon:@"MoreNetease" title:@"产品推荐" vcClass:[ZPCollectionViewController class]];
    ZPSettingArrowItem *aboutItem = [ZPSettingArrowItem itemWithIcon:@"MoreAbout" title:@"关于" vcClass:[ZPAboutViewController class]];
    group1.itemsArray = [NSArray arrayWithObjects:updateItem, helpItem, shareItem, examineMsgItem, productRecommendationsItem, aboutItem, nil];
    
    group1.header = @"头部1";
    group1.footer = @"尾部1";
    
    [self.mutableArray addObject:group1];
}

@end
