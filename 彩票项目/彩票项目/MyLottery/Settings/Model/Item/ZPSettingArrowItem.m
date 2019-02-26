//
//  ZPSettingArrowItem.m
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPSettingArrowItem.h"

@implementation ZPSettingArrowItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)destVcClass
{
    ZPSettingArrowItem *item = [[self alloc] init];
    
    item.icon = icon;
    item.title = title;
    item.vcClass = destVcClass;
    
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title vcClass:(Class)vcClass
{
    return [self itemWithIcon:nil title:title vcClass:vcClass];
}

@end
