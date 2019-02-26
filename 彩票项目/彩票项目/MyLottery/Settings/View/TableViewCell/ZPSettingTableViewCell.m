//
//  ZPSettingTableViewCell.m
//  彩票项目
//
//  Created by apple on 16/7/30.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPSettingTableViewCell.h"
#import "ZPSettingItem.h"
#import "ZPSettingSwitchItem.h"
#import "ZPSettingArrowItem.h"
#import "ZPSettingLabelItem.h"

@interface ZPSettingTableViewCell ()

@property (nonatomic, strong) UIImageView *arrowView;  //箭头
@property (nonatomic, strong) UISwitch *switchView;  //开关
@property (nonatomic, strong) UILabel *label;  //文本框
@property (nonatomic, strong) UIView *divider;  //cell之间的分割线

@end

@implementation ZPSettingTableViewCell

#pragma mark ————— 创建cell对象 —————
+ (instancetype)cellWithTableView:(UITableView *)tableview
{
    static NSString *ID = @"setting";
    
    ZPSettingTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil)
    {
        cell = [[ZPSettingTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}

#pragma mark ————— 设置cell样式 —————
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        if (!iOS7)  //iOS7以下系统
        {
            //设置cell的背景色，使之与iOS7及以上系统的相同
            [self setupBackgroundView];
            
            //初始化cell中的子控件
            [self setupSubviews];
            
            //设置cell之间的分割线，使之与iOS7及以上系统的相同
            [self setupDivider];
        }
    }
    
    return self;
}

#pragma mark ————— 设置cell的背景色，使之与iOS7及以上的系统相同 —————
- (void)setupBackgroundView
{
    //因为在iOS7以下系统中的tableview的每个section的第一行都有一个圆角，想要去除圆角的话就要设置正常状态下cell的背景颜色
    UIView *normalBackground = [[UIView alloc] init];
    normalBackground.backgroundColor = [UIColor whiteColor];
    self.backgroundView =normalBackground;
    
    //设置选中状态下cell的背景颜色
    UIView *selectedBackground = [[UIView alloc] init];
    selectedBackground.backgroundColor = color(241, 240, 215);
    self.selectedBackgroundView = selectedBackground;
}

#pragma mark ————— 初始化cell中的子控件 —————
- (void)setupSubviews
{
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

#pragma mark ————— 设置cell之间的分割线，使之与iOS7及以上的系统相同 —————
- (void)setupDivider
{
    self.divider = [[UIView alloc] init];
    self.divider.backgroundColor = [UIColor blackColor];
    self.divider.alpha = 0.2;
    [self.contentView addSubview:self.divider];
    
}

#pragma mark ————— 设置cell的位置和宽高，使之与iOS7及以上的系统相同 —————
/**
 tableView控件会自动设置cell的位置和宽高，不用开发者去处理，但是在iOS7以下系统中cell的宽左右不到头，与屏幕的左右两个边缘有间隙，要想让它与iOS7及以上系统中的cell效果一样的话，就要重写tableView控件中设置cell位置和宽高的方法，即重写下面的方法。
 */
- (void)setFrame:(CGRect)frame
{
    if (!iOS7)  //iOS7以下系统
    {
        CGFloat padding = 10;
        frame.size.width += padding * 2;
        frame.origin.x = padding;
    }
    
    [super setFrame:frame];
}

#pragma mark ————— 隐藏cell之间的分割线 —————
//如果这个cell是分区中的最后一行的话则隐藏分割线。
-(void)setLastRowInSection:(BOOL)lastRowInSection
{
    _lastRowInSection = lastRowInSection;
    
    self.divider.hidden = lastRowInSection;
}

#pragma mark ————— 设置cell内部子控件的位置 —————
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (iOS7)
    {
        return;
    }else
    {
        //设置分割线的frame
        CGFloat dividerH = 1;
        CGFloat dividerW = [UIScreen mainScreen].bounds.size.width;
        CGFloat dividerX = 0;
        CGFloat dividerY = self.contentView.frame.size.height - dividerH;
        
        self.divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
}

#pragma mark ————— 设置cell上面的数据 —————
- (void)setItem:(ZPSettingItem *)item
{
    _item = item;
    
    if (item.icon)  //为了避免运行之后控制台出现"CUICatalog: Invalid asset name supplied: (null)"打印。
    {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    //设置cell右边的控件
    if ([self.item isKindOfClass:[ZPSettingArrowItem class]])  //箭头cell
    {
        //因为这个方法会被反复调用，所以要把这句代码写为懒加载，以节省内存。
        self.accessoryView = self.arrowView;
        
        //当cell为开关cell的时候会去除掉点击效果，但是之后的不是开关的cell重复利用的时候有可能会利用到原来有开关的那个cell，则点击的话不会有点击效果，所以在这里应该设置恢复点击效果。
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else if ([self.item isKindOfClass:[ZPSettingSwitchItem class]])  //开关cell
    {
        self.accessoryView = self.switchView;
        self.selectionStyle = UITableViewCellSeparatorStyleNone;  //使此cell不能够点击
        
        //从沙盒中取出开关的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchView.on = [defaults boolForKey:self.item.title];
    }else if ([self.item isKindOfClass:[ZPSettingLabelItem class]])  //文本框cell
    {
        self.accessoryView = self.label;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }else  //cell的最右边什么控件也没有
    {
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
}

#pragma mark ————— 懒加载 —————
- (UIImageView *)arrowView
{
    if (_arrowView == nil)
    {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    }
    
    return _arrowView;
}

- (UISwitch *)switchView
{
    if (_switchView == nil)
    {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchStateChange) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchView;
}

- (UILabel *)label
{
    if (_label == nil)
    {
        _label = [[UILabel alloc] init];
        _label.bounds = CGRectMake(0, 0, 100, 30);  //如果不设置尺寸的话label控件无法显示
        _label.backgroundColor = [UIColor redColor];
    }
    
    return _label;
}

#pragma mark ————— 改变开关状态 —————
- (void)switchStateChange
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchView.isOn forKey:self.item.title];
    [defaults synchronize];
}

@end
