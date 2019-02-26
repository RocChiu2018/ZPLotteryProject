//
//  ZPCollectionViewController.m
//  彩票项目
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 apple. All rights reserved.
//

/**
 一般用iOS的"UICollectionViewController"类来做九宫格；
 每个格子是一个"UICollectionViewCell"；
 一个item对应着一个UICollectionViewCell；
 每一行有几个格子(UICollectionViewCell)取决于collectionView的宽度和格子的大小；
 与UITableViewController用indexPath来标识UITableViewCell所处的组(section)和行(row)相似，UICollectionViewController也用indexPath来标识UICollectionViewCell所处的组(section)和项目(item)，UITableView中的section就相当于UICollectionView中的section，UITableView中的row就相当于UICollectionView中的item，UITableView中的UITableViewCell就相当于UICollectionView中的UICollectionViewCell；
 UITableViewController的视图View就是它的UITableView控件，即self.view就是self.tableView。而与UITableViewController不同的是UICollectionViewController的视图View与它的UICollectionView控件不同，即self.view与self.collectionView不同，self.collectionView是加在self.view上的。
 */
#import "ZPCollectionViewController.h"
#import "ZPAPP.h"
#import "ZPCollectionViewCell.h"

@interface ZPCollectionViewController ()

@property (nonatomic, strong) NSArray *appsArray;

@end

@implementation ZPCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark ————— 懒加载 —————
-(NSArray *)appsArray
{
    if (_appsArray == nil)
    {
        //获取json文件的路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"products.json" ofType:nil];
        
        //把json文件变成二进制数据
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        
        //解析json数据
        NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //封装对象
        NSMutableArray *mutableArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray)
        {
            ZPAPP *app = [ZPAPP appWithDictionary:dict];
            
            [mutableArray addObject:app];
        }
        
        _appsArray = mutableArray;
    }
    
    return _appsArray;
}

#pragma mark ————— 创建方法 —————
/**
 UICollectionViewController只能通过"initWithCollectionViewLayout:"方法传入一个布局参数才能够创建成功，UICollectionViewController不能使用init方法进行创建，因为对于此类而言没有init创建方法；
 布局参数((UICollectionViewLayout *)layout)是指UICollectionViewCell按照什么样的样式进行排布。最普通的布局参数是流水布局((UICollectionViewFlowLayout *)layout)，此外还有“瀑布流”布局等等；
 每个格子(UICollectionViewCell)的尺寸由布局参数((UICollectionViewLayout *)layout)的itemSize属性来决定，如果不写的话则使用默认的尺寸大小。
 
 在ZPBaseSettingTableViewController类中点击cell都是通过init方法创建的目标视图控制器的，但是对于UICollectionViewController类而言只能通过"initWithCollectionViewLayout:"方法传入一个布局参数才能够创建出目标视图控制器，不能为了创建一个UICollectionViewController而改变其他视图控制器的创建方法(init)，所以在本类中重写init方法才能有效的解决这一问题。
 */
-(id)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置格子的尺寸大小（不管是用代码还是xib的形式加载cell，都要写这句话，不写的话则使用默认的尺寸）
    layout.itemSize = CGSizeMake(80, 80);
    
    //设置cell之间的水平距离
    layout.minimumInteritemSpacing = 0;
    
    //设置cell之间的垂直距离
    layout.minimumLineSpacing = 10;
    
    //设置collectionView与屏幕四周的间距
    layout.sectionInset = UIEdgeInsetsMake(layout.minimumLineSpacing, 0, 0, 0);
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        
    }
    
    return self;
}

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /**
     如果使用xib创建"UICollectionViewCell"的话需要用以下代码对"UICollectionViewCell"进行注册。
     */
    UINib *nib = [UINib nibWithNibName:@"ZPCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    /**
     如果使用代码创建"UICollectionViewCell"的话需要用以下代码注册"UICollectionViewCell"，告诉collectionView如果缓存池中没有找到带有标识符的UICollectionViewCell的话怎样创建UICollectionViewCell。
     */
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //设置collectionView的背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark ————— UICollectionViewDataSource —————
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.appsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     创建"UITableViewCell"和"UICollectionViewCell"对象的写法对比：
     1、代码方式：
     （1）UITableViewCell：在一个视图控制器类中的"cellForRowAtIndexPath:"方法中设置完了重用标识之后，再从缓存池中寻找带有此特殊标识符的cell，如果没有找到的话可以调用"UITableViewCell"类中的"initWithStyle: reuseIdentifier: "方法来创建一个新的带有上述特殊标识符的cell。如果不用此方法创建新的cell的话则应该在那个视图控制器类中的"viewDidLoad"方法中调用"registerClass: forCellReuseIdentifier: "方法来注册一个带有上述特殊标识符的cell，从而系统会根据这行代码创建一个新的注册过的cell；
     （2）UICollectionViewCell：在一个视图控制器类中的"cellForItemAtIndexPath:"方法中先设置一个重用标识符，然后再从缓存池中寻找带有此特殊标识符的cell，如果没有找到的话，与上述创建"UITableViewCell"对象时不同，因为"UICollectionViewCell"类中没有"initWithStyle: reuseIdentifier: "方法，只有"init"方法，所以没办法创建带有上述特殊标识符的"UICollectionViewCell"对象，所以只能在那个视图控制器类中的"viewDidLoad"方法中调用"registerClass: forCellWithReuseIdentifier: "方法来注册一个带有上述特殊标识符的cell，从而系统会根据这行代码创建一个新的注册过的cell。
     2、xib方式：
     （1）UITableViewCell：在一个视图控制器类中的"cellForRowAtIndexPath:"方法中先设置一个重用标识符，然后再从缓存池中寻找带有此特殊标识符的cell，如果没有找到的话可以调用"loadNibNamed: owner: options: "方法来加载自定义cell的xib文件，并且要在xib文件中写上上述的特殊标识符，只有这样的话系统才能创建一个新的带有上述特殊标识符的自定义cell对象。如果不用"loadNibNamed: owner: options: "方法来加载自定义cell的xib文件的话，则应该在那个视图控制器类中的"viewDidLoad"方法中先调用"nibWithNibName:"方法来获取自定义cell的xib文件，然后再调用"registerNib: forCellReuseIdentifier: "方法来注册一个带有上述特殊标识符的cell，同样也要在自定义cell的xib文件中写上上述的特殊标识符，只有这样的话系统才能创建一个新的带有上述特殊标识符的自定义cell的对象；
     （2）UICollectionViewCell：在一个视图控制器类中的"cellForItemAtIndexPath:"方法中先设置一个重用标识符，然后再从缓存池中寻找带有此特殊标识符的cell，与上述创建自定义"UITableViewCell"类的对象不同，后面就不用再写如果没有找到的话会如何，应该直接在那个视图控制器类中的"viewDidLoad"方法中调用"registerNib: forCellWithReuseIdentifier: "方法来注册一个带有上述特殊标识符的cell，同样也要在自定义cell的xib文件中写上上述的特殊标识符，只有这样的话系统才能创建一个新的带有上述特殊标识符的自定义cell的对象。
     */
    
    ZPCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.app = [self.appsArray objectAtIndex:indexPath.item];
    
    return cell;
}

#pragma mark ————— UICollectionViewDelegate —————
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     想要由本程序跳转到其他程序中，必须要知道其他程序的协议路径。协议路径在开发过程时写在了Xcode的"TARGETS"中的"Info"里面的"Custom iOS Target Properties"里面，在其中要加一项"URL types"，里面的"URL identifier"的值为路径，里面的"URL Schemes"的值为协议名（协议名也可以不写）。在其他项目中加完了协议路径之后，协议路径就会写在"TARGETS"中的"Info"里面的"URL Types"里面。
     */
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"zp://ios.itcast.cn"]];
    
    ZPAPP *app = [self.appsArray objectAtIndex:indexPath.item];
    
    //获取将要跳转的APP的协议路径
    NSURL *customUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@://%@", app.scheme, app.identifier]];
    
    UIApplication *application = [UIApplication sharedApplication];
    if ([application canOpenURL:customUrl])  //如果能跳转的话，则直接跳转到其他应用
    {
        [application openURL:customUrl];
    }else  //如果不能跳转的话（手机上没有那个APP），则打开APP Store上那个应用的下载页，让用户进行下载
    {
        [application openURL:[NSURL URLWithString:app.url]];
    }
}

@end
