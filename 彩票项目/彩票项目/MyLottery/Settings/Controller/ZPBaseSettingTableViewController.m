//
//  ZPSettingTableViewController.m
//  彩票项目
//
//  Created by apple on 16/7/29.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 MVC分层设计模式中视图控制器层（V）的作用：在视图控制器类中通过网络从后台获取到json数据，然后利用已经封装好的数据层（M）把这些json数据封装成对象，最后再把这些对象传递给已经封装好的视图层（V），让视图层来显示数据。视图控制器层起到了连接数据层和视图层的作用，是一个承上启下的作用。
 */
#import "ZPBaseSettingTableViewController.h"
#import "ZPSettingGroup.h"
#import "ZPSettingTableViewCell.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingItem.h"
#import "MBProgressHUD+MJ.h"
#import "ZPCollectionViewController.h"
#import "ZPPushAndRemindTableViewController.h"

@interface ZPBaseSettingTableViewController ()

@end

@implementation ZPBaseSettingTableViewController

#pragma mark ————— 懒加载 —————
-(NSMutableArray *)mutableArray
{
    if (_mutableArray == nil)
    {
        _mutableArray = [NSMutableArray array];
    }
    
    return _mutableArray;
}

#pragma mark ————— 初始化方法 —————
/**
 在其他类中创建表格视图控制器（本类的子类）的时候不要使用"initWithStyle:"方法来进行初始化，要使用下面的"init"方法，因为基于解耦合的原则，关于表格视图控制器的代码还是要尽量写在本类里面，目的就是把关于本类的代码屏蔽起来，不让其他类知道，这样的话其他类就不能更改本类的代码了，就具有了很好的专属性和私密性了。
 */
-(instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        ;
    }
    
    return self;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置tableview的背景颜色：
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]];
}

#pragma mark ————— UITableViewDataSource —————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.mutableArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZPSettingGroup *group = [self.mutableArray objectAtIndex:section];
    
    return group.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    ZPSettingTableViewCell *cell = [ZPSettingTableViewCell cellWithTableView:tableView];
    
    //设置cell的数据
    ZPSettingGroup *group = [self.mutableArray objectAtIndex:indexPath.section];
    cell.item = [group.itemsArray objectAtIndex:indexPath.row];
    
    //判断是否是最后一行
    cell.lastRowInSection = (group.itemsArray.count - 1 == indexPath.row);
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZPSettingGroup *group = [self.mutableArray objectAtIndex:section];
    
    return group.header;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZPSettingGroup *group = [self.mutableArray objectAtIndex:section];
    
    return group.footer;
}

#pragma mark ————— UITableViewDelegate —————
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     当用户点击cell以后，该cell会显示灰色，如果不写这句代码的话灰色会一直显示。为了让用户点击完cell以后，该cell只显示一下灰色，随后就消失，就要撰写下面这句代码。
     */
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ZPSettingGroup *group = [self.mutableArray objectAtIndex:indexPath.section];
    ZPSettingItem *item = [group.itemsArray objectAtIndex:indexPath.row];
    
    if (item.option)  //点击这个cell，有特定的操作需要执行
    {
        //block的调用
        item.option();
    }else if ([item isKindOfClass:[ZPSettingArrowItem class]])  //点击带箭头的cell会push到一个新的视图控制器中
    {
        ZPSettingArrowItem *arrowItem = (ZPSettingArrowItem *)item;
        
        if (arrowItem.vcClass == nil)
        {
            return;
        }else
        {
            UIViewController *vc = [[arrowItem.vcClass alloc] init];
            vc.navigationItem.title = arrowItem.title;  //设置即将push到的新的视图控制器的标题
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end
