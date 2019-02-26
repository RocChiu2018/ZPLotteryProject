//
//  ZPAboutViewController.m
//  彩票项目
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPAboutViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingGroup.h"

@interface ZPAboutViewController ()

@end

@implementation ZPAboutViewController

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
    
    ZPSettingArrowItem *gradeItem = [ZPSettingArrowItem itemWithTitle:@"评分支持" vcClass:nil];
    gradeItem.option = ^{
        /**
         在苹果开发者网站里点击itunes connect，进入到已发布程序的界面，点开要评分的程序，里面的Apple ID即是这里的参数值。
         */
        NSString *appID = @"1050575213";
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appID]];
        [[UIApplication sharedApplication] openURL:url];
    };
    
    ZPSettingArrowItem *serviceTelItem = [ZPSettingArrowItem itemWithTitle:@"客服电话" vcClass:nil];
    serviceTelItem.subtitle = @"10086";
    
    /**
     第一种撰写打电话代码的方式：
     这种方式在打完电话之后会跳回到原来的应用中，不足之处在于没有将要拨打电话的提示框。
     */
//    serviceTelItem.option = ^{
//        NSURL *url = [NSURL URLWithString:@"tel://10086"];
//        [[UIApplication sharedApplication] openURL:url];
//    };
    
    /**
     第二种撰写打电话代码的方式：
     这种方式在拨通电话之前会有一个提示框提示用户将要拨通电话，并且打完电话之后会直接跳回到原来的程序之中，不足之处在于这个协议是私有的API，苹果在审核的时候可能不会通过。
     */
//    serviceTelItem.option = ^{
//        NSURL *url = [NSURL URLWithString:@"telprompt://10086"];
//        [[UIApplication sharedApplication] openURL:url];
//    };
    
    /**
     第三种撰写打电话代码的方式（推荐）：
     这种方式在拨通电话之前会有一个提示框提示用户将要拨通电话，并且打完电话之后会直接跳回到原来的程序之中。
     */
    UIWebView *webView = [[UIWebView alloc] init];
    [self.view addSubview:webView];
    
    serviceTelItem.option = ^{
        NSURL *url = [NSURL URLWithString:@"tel://10086"];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
    };
    
    group.itemsArray = [NSArray arrayWithObjects:gradeItem, serviceTelItem, nil];
    
    [self.mutableArray addObject:group];
    
    //设置tableView的tableHeaderView
    self.tableView.tableHeaderView = [UIButton buttonWithType:UIButtonTypeContactAdd];
}

@end
