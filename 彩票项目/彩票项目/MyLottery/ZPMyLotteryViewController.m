//
//  ZPMyLotteryViewController.m
//  彩票项目
//
//  Created by apple on 16/7/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPMyLotteryViewController.h"
#import "ZPSettingTableViewController.h"

@interface ZPMyLotteryViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;  //登录按钮

@end

@implementation ZPMyLotteryViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *normal = [UIImage imageNamed:@"RedButton"];
    UIImage *highlighted = [UIImage imageNamed:@"RedButtonPressed"];  //要想按钮在高亮的时候使用自己的图片就要把按钮设为Custom类型。
    
    /**
     图片拉伸方法2：使用"stretchableImageWithLeftCapWidth: topCapHeight: "方法来处理图片。
     这个方法是苹果最早处理图片拉伸的方法；
     调用这个方法之后，系统会根据传入的图片左边和上边的需要保护的区域来推算出图片右边和下边需要保护的区域。调用这个方法时不管参数传入的是多少，最后系统算出的需要拉伸的区域都是图片最中间的1*1的地方，所以说这个方法只拉伸图片最中间的1*1的区域；
     调用这个方法时一般传入的左边需要被保护的区域为图片宽度的一半，上边需要保护的区域为图片高度的一半。
     */
    normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
    highlighted = [highlighted stretchableImageWithLeftCapWidth:highlighted.size.width * 0.5 topCapHeight:highlighted.size.height * 0.5];
    
    [self.loginButton setBackgroundImage:normal forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:highlighted forState:UIControlStateHighlighted];
}

#pragma mark ————— 点击导航栏上的“设置”按钮 —————
- (IBAction)clickSettingButton:(id)sender
{
    ZPSettingTableViewController *settingTableViewController = [[ZPSettingTableViewController alloc] init];
    [self.navigationController pushViewController:settingTableViewController animated:YES];
}

@end
