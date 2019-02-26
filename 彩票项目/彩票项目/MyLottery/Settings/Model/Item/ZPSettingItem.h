//
//  ZPSettingItem.h
//  彩票项目
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 在这个模块中的表格视图控制器中的每行cell对应着一个对象，鉴于每行cell的样子都差不多，为了减少代码量，所以就创建了一个每行cell对应的模型的父类，之后根据每行cell的特殊性再创建继承于这个父类的子类。
 */
#import <Foundation/Foundation.h>

typedef void (^BlockOption)();

//鉴于每个分区里面的每行cell的不同性，可以创建继承于这个父类对象类的子类对象类也可以使用枚举的方法，创建几个对象类。
//typedef enum{
//    ZPSettingItemTypeArrow,
//    ZPSettingItemTypeSwitch
//} ZPSettingItemType;

@interface ZPSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;  //图标
@property (nonatomic, copy) NSString *title;  //标题
@property (nonatomic, copy) NSString *subtitle;  //子标题（cell最右边显示的文字）
//@property (nonatomic, assign) ZPSettingItemType type;  //cell最右边的控件
@property (nonatomic, copy) BlockOption option;  //点击本cell后触发的动作

@end
