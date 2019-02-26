//
//  ZPViewController.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPHtmlViewController.h"
#import "ZPHtml.h"

@interface ZPHtmlViewController () <UIWebViewDelegate>

@end

@implementation ZPHtmlViewController

#pragma mark ————— 加载View —————
/**
 此方法先于"viewDidLoad"方法而被调用；
 此方法用来自定义view。
 */
-(void)loadView
{
    self.view = [[UIWebView alloc] init];  //让整个view成为webview
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏的标题
    self.navigationItem.title = self.html.title;
    
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    
    /**
     获取文件路径：
     得到的文件路径内有中文。
     */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.html.html ofType:nil];
    NSLog(@"filePath = %@", filePath);
    
    //如果把内含中文的文件路径转换为NSURL的话则得到的结果为null，所以要利用下行代码把内含中文的文件路径转换掉。
    filePath = [filePath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"filePath = %@", filePath);
    
    //把文件路径转化为url
    NSURL *url = [NSURL URLWithString:filePath];
    NSLog(@"url = %@", url);
    
    /**
     可以利用下行的方法把文件路径转换为url，如果在转换的过程中文件路径有中文的话利用下行的方法也会把中文转换掉；
     下行的一句代码可以代替上面的三行代码。
     */
//    NSURL *url = [[NSBundle mainBundle] URLForResource:self.html.html withExtension:nil];
//    NSLog(@"url = %@", url);
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //发送请求
    [webView loadRequest:request];
    
    //设置左上角的关闭按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
}

#pragma mark ————— 点击“关闭”按钮 —————
-(void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ————— UIWebViewDelegate —————
/**
 网页加载完毕的时候系统会自动调用这个方法；
 在这个方法中可以使用oc调用js代码。
 */
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //跳到id对应的网页标签
    NSString *js = [NSString stringWithFormat:@"window.location.href = '#%@';", self.html.ID];
    
    [webView stringByEvaluatingJavaScriptFromString:js];  //oc调用js代码
}

@end
