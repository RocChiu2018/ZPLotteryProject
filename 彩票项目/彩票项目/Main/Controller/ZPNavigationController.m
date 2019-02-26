//
//  ZPNavigationController.m
//  彩票项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPNavigationController.h"

@interface ZPNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, weak) id gestureRecognizerDelegate;  //用来存储滑动返回的代理

@end

@implementation ZPNavigationController

#pragma mark ————— 类的初始化方法 —————
/**
 系统在第一次使用这个类或者它的子类的时候会调用这个方法，并且只会调用一次。
 */
+ (void)initialize
{
    /**
     获取导航栏的主题：整个项目的导航栏都与这个主题相同。
     */
    
    /**
     获取导航栏主题方法1：
     这种写法在真机调试的时候可能会产生bug，所以不推荐使用这种写法。
     */
//    UINavigationBar *navBar = [UINavigationBar appearance];
    
    /**
     获取导航栏主题方法2：
     "appearanceWhenContainedIn:"方法的意思是获取哪个类的导航条，后面的参数传入self就代表获取本类的导航条；
     这种写法在真机调试的时候不会产生bug，所以推荐使用这种写法。
     */
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    /**
     设置导航栏的背景图片：
     retina屏的情况下：iOS6系统下的导航栏的高度是88像素，iOS7及以上系统下导航栏与状态栏应该算作一体，在这种情况下想要设置导航栏的背景图片的话就需要高为128像素的图片了。
     */
    NSString *bgImage = nil;
    if (iOS7)  //iOS7及以上的系统
    {
        bgImage = @"NavBar64";
        
        /**
         修改导航栏上系统原生的返回按钮的颜色：
         导航栏上系统原生的返回按钮的颜色默认是蓝色的，如果需要更改它的颜色的话就要撰写下行的代码；
         当页面push到视图控制器栈中的非根视图控制器的时候，如果导航栏上的返回按钮使用的是系统原生的话则自带滑动返回功能，如果使用的是自定义返回按钮的话则原来自带的滑动返回功能就会消失。由于下面的代码仅仅是修改系统原生的返回按钮的颜色，所以系统自带的滑动返回功能不会消失。
         */
        navBar.tintColor = [UIColor whiteColor];
    }else   //iOS7以下的系统
    {
        bgImage = @"NavBar";
    }
    
    [navBar setBackgroundImage:[UIImage imageNamed:bgImage] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏标题文字的颜色和大小
    NSMutableDictionary *attributeDict = [NSMutableDictionary dictionary];
    [attributeDict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [attributeDict setObject:[UIFont systemFontOfSize:19] forKey:NSFontAttributeName];
    [navBar setTitleTextAttributes:attributeDict];
    
    /**
     获取UIBarButtonItem的主题：整个项目的item都与这个主题相同。
     */
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //设置item的颜色和大小
    NSMutableDictionary *itemAttributeDict = [NSMutableDictionary dictionary];
    [itemAttributeDict setObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    [itemAttributeDict setObject:[UIFont systemFontOfSize:16] forKey:NSFontAttributeName];
    [item setTitleTextAttributes:itemAttributeDict forState:UIControlStateNormal];
    
    //在iOS7（不含）以下的系统中设置item的背景图片
    if (!iOS7) 
    {
        //在iOS6系统中设置item的背景图片
        [item setBackgroundImage:[UIImage imageNamed:@"NavButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageNamed:@"NavButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        
        //在iOS6系统中设置返回按钮的背景图片
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
}

#pragma mark ————— 生命周期 —————
//这个方法会被调用五次，因为一共有五个导航控制器，每个导航控制器生成的时候都会调用一次这个方法。
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //把<UIGestureRecognizerDelegate>代理赋值给本类的一个对象存储起来。
    self.gestureRecognizerDelegate = self.interactivePopGestureRecognizer.delegate;
    
    //设置<UINavigationControllerDelegate>代理为本类。
    self.delegate = self;
}

#pragma mark ————— push方法 —————
//重写这个方法的目的就是让页面每次跳转到新的视图控制器的时候下面的tabbar隐藏，不用每次都在storyboard中设置了。
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //先调用父类的这个方法
    [super pushViewController:viewController animated:animated];
    
    //push到视图控制器栈里面的视图控制器是非根视图控制器的时候才需要隐藏那个tabbar了。
    if (self.viewControllers.count != 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
        
        /**
         自定义导航栏的返回按钮：
         导航栏上的返回按钮由于使用了自定义的按钮所以原来系统自带的滑动返回功能就消失了。
         */
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        
        /**
         如果导航栏上的返回按钮使用的是自定义按钮而又想让系统自带的滑动返回功能不消失的话，就需要在本方法中撰写下面的代码使<UIGestureRecognizerDelegate>代理为nil。这样做之后，虽然视图控制器栈中的非根视图控制器具备了滑动返回的功能，但是当pop到此导航视图控制栈中的根视图控制器中以后，如果用户在这个根视图控制器中模仿滑动返回动作（在根视图控制器中的左侧做向右滑动的动作）之后，再点击这个根视图控制器导航栏右侧的“设置”按钮，则程序会崩溃。为了修复上述的问题，在程序运行以后，首先要在本类中的"viewDidLoad"方法中把"self.interactivePopGestureRecognizer.delegate"赋值给本类的一个属性，用来把它存储住，再在新的视图控制器push到视图控制器栈中的时候（本方法）把"self.interactivePopGestureRecognizer.delegate"设为nil，最后在pop回视图控制器栈中的根视图控制器的方法(navigationController: didShowViewController: animated: )中把之前利用属性存储的"self.interactivePopGestureRecognizer.delegate"再赋值回来即可。
         */
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark ————— 点击导航栏上的返回按钮 —————
- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark ————— UINavigationControllerDelegate —————
//当视图控制器push或pop完之后，系统就会自动调用这个代理方法。
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /**
     方法中的viewController参数代表的是系统push或pop后显示的新的视图控制器；
     判断新的视图控制器是不是栈中的根视图控制器。
     */
    if (viewController == [self.viewControllers firstObject])
    {
        self.interactivePopGestureRecognizer.delegate = self.gestureRecognizerDelegate;
    }
}

@end
