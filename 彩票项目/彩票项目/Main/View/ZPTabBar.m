//
//  ZPTabBar.m
//  彩票项目
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPTabBar.h"
#import "ZPButton.h"

@interface ZPTabBar ()

@property (nonatomic, weak) ZPButton *selectedButton;

@end

@implementation ZPTabBar

#pragma mark ————— 设置tabbar内部按钮的尺寸 —————
-(void)layoutSubviews
{
    for (int i = 0; i < self.subviews.count; i++)
    {
        ZPButton *button = [self.subviews objectAtIndex:i];
        
        //设置按钮的tag
        button.tag = i;
        
        //设置子控件的frame
        CGFloat buttonY = 0;
        CGFloat buttonW = self.frame.size.width / self.subviews.count;
        CGFloat buttonH = self.frame.size.height;
        CGFloat buttonX = i * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    }
}

#pragma mark ————— 添加tabbar内部的按钮 —————
- (void)addTabBarButtonWithNormalName:(NSString *)normalName selectedName:(NSString *)selectedName
{
    ZPButton *button = [[ZPButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:normalName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedName] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];  //UIControlEventTouchDown：手指一按下去就会触发相应的方法。
    [self addSubview:button];
    
    //默认选中第0个按钮
    if (self.subviews.count == 1)
    {
        [self buttonClick:button];
    }
}

#pragma mark ————— 点击tabbar上面的按钮 —————
- (void)buttonClick:(ZPButton *)button
{
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
}

@end
