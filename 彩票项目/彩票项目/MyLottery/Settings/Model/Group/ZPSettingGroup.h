//
//  ZPSettingGroup.h
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

//表格视图控制器中的分区对象类。

#import <Foundation/Foundation.h>

@interface ZPSettingGroup : NSObject

@property (nonatomic, copy) NSString *header;  //头部标题
@property (nonatomic, copy) NSString *footer;  //尾部标题
@property (nonatomic, strong) NSArray *itemsArray;  //存放ZPSettingItem对象的数组

@end
