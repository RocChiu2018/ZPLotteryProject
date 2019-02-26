//
//  ZPHelpViewController.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPHelpViewController.h"
#import "ZPSettingItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPHtmlViewController.h"
#import "ZPSettingGroup.h"
#import "ZPNavigationController.h"
#import "ZPHtml.h"
#import "NSObject+ZPModel.h"

@interface ZPHelpViewController ()

@property (nonatomic, strong) NSArray *htmlsArray;

@end

@implementation ZPHelpViewController

#pragma mark ————— 懒加载 —————
- (NSArray *)htmlsArray
{
    if (_htmlsArray == nil)
    {
        //获取json文件的路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help.json" ofType:nil];
        
        //把json文件变成二进制数据
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        //解析json数据
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //封装对象
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray)
        {
            //使用普通方法封装对象
//            ZPHtml *html = [ZPHtml htmlWithDictionary:dict];
            
            //使用KVC方式封装对象
//            ZPHtml *html = [ZPHtml useKVCMethodPackagingObjectWithDict:dict];
            
            //使用运行时方式封装对象
            ZPHtml *html = [ZPHtml useRuntimeMethodPackagingObjectWithDict:dict mapDict:[NSDictionary dictionaryWithObject:@"id" forKey:@"ID"]];
            
            [mutableArray addObject:html];
        }
        
        _htmlsArray = mutableArray;
    }
    
    return _htmlsArray;
}

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
    
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (ZPHtml *html in self.htmlsArray)
    {
        ZPSettingArrowItem *item = [ZPSettingArrowItem itemWithTitle:html.title vcClass:nil];
        [mutableArray addObject:item];
    }
    
    group.itemsArray = mutableArray;
    
    [self.mutableArray addObject:group];
}

#pragma mark ————— UITableViewDelegate —————
/**
 子类重写父类的方法，系统就会优先调用子类的方法而忽略父类的方法。
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZPHtmlViewController *htmlVC = [[ZPHtmlViewController alloc] init];
    htmlVC.html = [self.htmlsArray objectAtIndex:indexPath.row];
    
    ZPNavigationController *nav = [[ZPNavigationController alloc] initWithRootViewController:htmlVC];
    
    [self presentViewController:nav animated:YES completion:nil];
}

@end
