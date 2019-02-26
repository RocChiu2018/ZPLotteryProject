//
//  ZPSettingLabelItem.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPSettingLabelItem.h"

@implementation ZPSettingLabelItem

+ (instancetype)itemWithTitle:(NSString *)title
{
    ZPSettingLabelItem *item = [[ZPSettingLabelItem alloc] init];
    
    item.title = title;
    
    return item;
}

@end
