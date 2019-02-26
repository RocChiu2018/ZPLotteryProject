//
//  ZPTabBarController.m
//  彩票项目
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTabBarController.h"
#import "ZPTabBar.h"

@interface ZPTabBarController () <ZPTabBarDelegate>

@end

@implementation ZPTabBarController

#pragma mark ————— 生命周期 —————
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    ZPTabBar *tabBar = [[ZPTabBar alloc] init];  //创建自定义的tabBar
    tabBar.frame = self.tabBar.bounds;
    tabBar.delegate = self;
    [self.tabBar addSubview:tabBar];  //把自定义的tabbar添加到系统的tabbar上面
    
    //给新创建的自定义tabBar上面添加按钮
    for (int i = 0; i < self.viewControllers.count; i++)
    {
        NSString *normalName = [NSString stringWithFormat:@"TabBar%d", i + 1];
        NSString *selectedName = [NSString stringWithFormat:@"TabBar%dSel", i + 1];
        
        [tabBar addTabBarButtonWithNormalName:normalName selectedName:selectedName];
    }
}

#pragma mark ————— ZPTabBarDelegate —————
- (void)tabBar:(ZPTabBar *)tabBar didSelectButtonFrom:(NSInteger)from to:(NSInteger)to
{
    //selectedIndex为UITabBarController特有的属性
    self.selectedIndex = to;
}

@end
