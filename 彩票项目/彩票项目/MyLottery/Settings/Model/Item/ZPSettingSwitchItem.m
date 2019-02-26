//
//  ZPSettingSwitchItem.m
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPSettingSwitchItem.h"

@implementation ZPSettingSwitchItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    ZPSettingSwitchItem *item = [[ZPSettingSwitchItem alloc] init];
    
    item.icon = icon;
    item.title = title;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}

@end
