//
//  ZPBaseSettingTableViewController.h
//  彩票项目
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 在这个模块中因为所有的页面都是表格的形式而且样子上也都差不多，为了减少代码量，所以就创建了一个UITableViewController类的子类用来作为模块中其他表格视图控制器的父类；
 当加载某个表格视图控制器的时候，首先系统会调用这个视图控制器类里面的相应的方法，如果在这个视图控制器类里面没有找到将要调用的方法的话系统就会到这个类的父类中去找，然后运行这个方法；
 把子类中相同的方法和属性都放在父类中，把不同的方法和属性放在各自的子类中，这样做可以使代码更加简洁，每个子类的作用更加突出；
 父类和子类方法里面都要使用self，而不要用本类的类名，这样哪个子类调用父类里面的方法，父类方法返回的都是子类的对象。
 */
#import <UIKit/UIKit.h>

@interface ZPBaseSettingTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *mutableArray;  //用来存储有多少组

@end
