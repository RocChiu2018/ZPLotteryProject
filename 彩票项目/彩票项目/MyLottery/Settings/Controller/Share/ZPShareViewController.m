//
//  ZPShareViewController.m
//  彩票项目
//
//  Created by apple on 16/8/12.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 真机调试的主要步骤：
 1、登录开发者网站；
 2、生成cer证书：cer证书是一个跟电脑相关联的证书文件，让电脑具备真机调试的功能；
 3、添加App ID：调试哪些app？
 4、注册真机设备：哪台设备需要做真机调试？
 5、生成MobileProvision文件：结合2、3、4步骤生成一个手机配置概要文件；
 6、导入cer、MobileProvision文件。
 */
#import "ZPShareViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingGroup.h"
#import <MessageUI/MessageUI.h>  //用来发送短信和邮件的专用库

@interface ZPShareViewController () <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@end

@implementation ZPShareViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupGroup];
}

#pragma mark ————— 设置数据 —————
- (void)setupGroup
{
    ZPSettingGroup *group = [[ZPSettingGroup alloc] init];
    
    ZPSettingArrowItem *sina = [ZPSettingArrowItem itemWithIcon:@"WeiboSina" title:@"新浪微博" vcClass:nil];
    ZPSettingArrowItem *sms = [ZPSettingArrowItem itemWithIcon:@"SmsShare" title:@"短信分享" vcClass:nil];
    
    /**
     block函数的循环引用：此视图控制器内有一个可变数组"mutableArray"属性，此属性指向一个可变数组，这个可变数组中又装着一个或多个"ZPSettingGroup"对象，"ZPSettingGroup"对象里面有一个"itemsArray"属性，这个属性指向一个不可变数组，这个不可变数组里面又装着一个或多个"ZPSettingItem"类的子类对象，这个子类对象里面有一个block属性，系统一遇到block属性，就会把block代码块内的所有对象进行强引用，即代码块内的所有对象都用强指针指着，所以下面的代码块内的"mailViewController"对象和"self"对象都用强指针指着，而"self"对象代表的是本视图控制器自己，所以本视图控制器也被强指针指着，根据上面所述的，本视图控制器又用强指针指着一个可变数组，所以说本视图控制器用强指针指着别人的同时自己也被强指针指着，这样被强指针指着的对象没有办法被释放掉，就造成了内存的泄露，这种问题叫做block函数的循环引用问题。想要解决这个问题就要在block代码块的外面声明代码块里面所引用的"self"对象是弱引用，即用弱指针指着它。声明的方式有如下的三种：
     1、"__unsafe_unretained ZPShareViewController *shareViewController = self;"；
     2、"__weak ZPShareViewController *weakSelf = self;"：这里用"__weak"的好处在于不但可以指明block引用的是弱指针，还可以防止野指针的出现，因为一旦对象不指着任何东西的话，会立马把对象变为空指针(nil)；
     3、"__weak typeof(self) weakSelf = self;"："typeof"表示获取括号里面的类型，在项目中通常使用这种写法。
     */
    __weak typeof(self) weakSelf = self;
    
    /**
     第一种发送短信的方法：
     这种方法的缺点在于发完短信之后就会停留在短信列表页面中，不能回到原来的程序中。
     */
//    sms.option = ^{
//        NSURL *url = [NSURL URLWithString:@"sms://10086"];
//        [[UIApplication sharedApplication] openURL:url];
//    };
    
    /**
     第二种发送短信的方法（推荐）：
     这种方法的好处在于发完短信之后能回到原来的程序中。
     */
    sms.option = ^{
        if (![MFMessageComposeViewController canSendText])  //因为模拟器不能发短信，所以要先判断一下
        {
            return;
        }else
        {
            MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
            
            //设置短信的内容
            messageViewController.body = @"你好！";
            
            //设置收件人列表
            messageViewController.recipients = [NSArray arrayWithObjects:@"10010", @"10086", nil];
            
            //设置代理
            messageViewController.messageComposeDelegate = weakSelf;
            
            //显示控制器
            [weakSelf presentViewController:messageViewController animated:YES completion:nil];
        }
    };
    
    ZPSettingArrowItem *mail = [ZPSettingArrowItem itemWithIcon:@"MailShare" title:@"邮件分享" vcClass:nil];
    
    /**
     第一种发送邮件的方法：
     这种方法的缺点在于发完邮件以后不能回到原来的程序中。
     */
//    mail.option = ^{
//        NSURL *url = [NSURL URLWithString:@"mailto://3877622609@qq.com"];
//        [[UIApplication sharedApplication] openURL:url];
//    };
    
    /**
     第二种发送邮件的方法（推荐）：
     这种方法的好处在于发完短信之后能回到原来的程序中。
     */
    mail.option = ^{
        if (![MFMailComposeViewController canSendMail])  //因为模拟器不能发送邮件，所以要先判断一下
        {
            return;
        }
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        
        //设置邮件主题
        [mailViewController setSubject:@"开会"];
        
        //设置邮件内容
        [mailViewController setMessageBody:@"时间定在今天下午一点" isHTML:NO];
        
        //设置收件人列表
        [mailViewController setToRecipients:[NSArray arrayWithObject:@"387762609@qq.com"]];
        
        //设置抄送人列表
        [mailViewController setCcRecipients:[NSArray arrayWithObject:@"743230051@qq.com"]];
        
        //设置密送人列表
        [mailViewController setBccRecipients:[NSArray arrayWithObject:@"nemozp@sina.cn"]];
        
        //添加附件（图片）
        UIImage *image = [UIImage imageNamed:@"018.png"];
        NSData *data = UIImagePNGRepresentation(image);
        [mailViewController addAttachmentData:data mimeType:@"image/png" fileName:@"018.png"];
        
        //设置代理
        mailViewController.mailComposeDelegate = weakSelf;
        
        //显示控制器
        [weakSelf presentViewController:mailViewController animated:YES completion:nil];
    };
    
    group.itemsArray = [NSArray arrayWithObjects:sina, sms, mail, nil];
    
    [weakSelf.mutableArray addObject:group];
}

#pragma mark ————— MFMessageComposeViewControllerDelegate —————
//发完短信或者点击短信右上角的“取消”按钮以后会触发这个方法
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ————— MFMailComposeViewControllerDelegate —————
//发完邮件或者点击邮件右上角的“取消”按钮以后会触发这个方法
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
