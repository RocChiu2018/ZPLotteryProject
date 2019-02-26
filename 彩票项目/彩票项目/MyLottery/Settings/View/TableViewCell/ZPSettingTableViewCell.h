//
//  ZPSettingTableViewCell.h
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 表格视图控制器中的每个分区中的每行cell所对应的视图类；
 每行cell对应一个ZPSettingItem模型。
 */
#import <UIKit/UIKit.h>

@class ZPSettingItem;

@interface ZPSettingTableViewCell : UITableViewCell

@property (nonatomic, strong) ZPSettingItem *item;
@property (nonatomic, assign, getter=isLastRowInSection) BOOL lastRowInSection;

+ (instancetype)cellWithTableView:(UITableView *)tableview;

@end
