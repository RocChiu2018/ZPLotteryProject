//
//  ZPTabBar.h
//  彩票项目
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

//自定义UITabBar类。

#import <UIKit/UIKit.h>

@class ZPTabBar;

@protocol ZPTabBarDelegate <NSObject>

@optional

- (void)tabBar:(ZPTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to;

@end

@interface ZPTabBar : UIView

@property (nonatomic, weak) id <ZPTabBarDelegate> delegate;

/**
 用来添加tabbar内部的按钮的方法；
 因为tabbar上面按钮的个数是由视图控制器来决定的，为了更好的分层，视图控制器调用几次本方法，就在tabbar上面添加几个按钮。
 */
- (void)addTabBarButtonWithNormalName:(NSString *)normalName selectedName:(NSString *)selectedName;

@end
