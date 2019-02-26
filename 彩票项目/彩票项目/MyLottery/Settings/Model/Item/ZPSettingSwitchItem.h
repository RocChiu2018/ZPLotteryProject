//
//  ZPSettingSwitchItem.h
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 最右侧带开关的cell对应的模型类；
 
 带开关的cell分为两种：
 1、最左边是图标，中间是标题，最右边是开关；
 2、最左边没有图标而是标题，最右边是开关；
 上述的这两种类型的cell点击之后不会有任何的反应；
 通过本类的两种封装方法对上述的两种带开关的cell进行封装。
 */
#import "ZPSettingItem.h"

@interface ZPSettingSwitchItem : ZPSettingItem

//上述1中的cell
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;

//上述2中的cell
+ (instancetype)itemWithTitle:(NSString *)title;

@end
