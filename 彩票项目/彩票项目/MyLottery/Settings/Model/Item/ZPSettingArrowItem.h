//
//  ZPSettingArrowItem.h
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 最右侧带箭头的cell对应的模型类。
 
 带箭头的cell分为两种：
 1、最左边是图标，中间是标题，最右边是箭头，点击这行cell会跳转到一个新的视图控制器中；
 2、最左边没有图标而是标题，最右边是箭头，点击这行cell会跳转到一个新的视图控制器中；
 通过本类的两种封装方法对上述的两种带箭头的cell进行封装。
 */
#import "ZPSettingItem.h"

@interface ZPSettingArrowItem : ZPSettingItem

@property (nonatomic, assign) Class vcClass;  //点击这行cell需要跳转到的视图控制器的名称

//上述1中的cell
+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title vcClass:(Class)vcClass;

//上述2中的cell
+ (instancetype)itemWithTitle:(NSString *)title vcClass:(Class)vcClass;

@end
