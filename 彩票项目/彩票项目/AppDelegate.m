//
//  AppDelegate.m
//  彩票项目
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 apple. All rights reserved.
//


/**
 在iOS6以前（包含iOS6），如果不做任何设置的话系统会对手机桌面上的icon图标自动进行玻璃质感的渲染，如果不想要渲染效果的话，就需要在Assets.xcassets文件夹中点击AppIcon文件，然后在"iOS icon is pre-rendered"前面打钩，这样做就等于告知系统图标已经渲染完了，不需要系统再进行渲染了。在iOS6以后，不管有没有打钩，系统都不会把icon图标自动进行渲染了。
 */
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /**
     状态栏本应该是由视图控制器来进行管理的，但是在本项目中由于视图控制器过多，为了避免造成混乱，所以状态栏让UIApplication类来统一进行管理。要想实现前述的目的，首先要在Info.plist文件中添加"View controller-based status bar appearance"Key，并且设置它的Value为"NO"，这样做的目的是不让视图控制器来管理状态栏，然后在本方法中撰写下面的代码。
     */
    
    /**
     系统默认状态栏内容的颜色是UIStatusBarStyleDefault（黑色）；
     在General中的Deployment Info中的Status Bar Style中选择其他颜色的话不管用，只能使用代码的方式来统一设置状态栏内容的颜色；
     UIStatusBarStyleDefault：状态栏的内容为黑色；
     UIStatusBarStyleLightContent：状态栏的内容为白色。
     */
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    /**
     程序刚打开的时候首先会加载欢迎页，等欢迎页加载完了之后才会进入到真正程序的首页中。如果想在加载欢迎页的时候不显示状态栏，但是加载程序首页的时候显示状态栏的话就应该撰写下行的代码，并且在General中的Deployment Info中的Hide status bar前面的选中框内打钩。
     */
    application.statusBarHidden = NO;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
