//
//  ZPSettingLabelItem.h
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 最右侧带Label的cell对应的模型类；
 最左边没有图标而是标题，最右边是UILabel控件，点击这个cell不会有任何反应。
 */
#import "ZPSettingItem.h"

@interface ZPSettingLabelItem : ZPSettingItem

+ (instancetype)itemWithTitle:(NSString *)title;

@end
