//
//  ZPPulldownButton.m
//  彩票项目
//
//  Created by apple on 16/7/26.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPPulldownButton.h"
#import <Availability.h>

@interface ZPPulldownButton ()

@property (nonatomic, strong) UIFont *labelFont;  //按钮里面文字的字号

@end

@implementation ZPPulldownButton

- (void)awakeFromNib
{
    self.labelFont = [UIFont systemFontOfSize:14];
    self.titleLabel.font = self.labelFont;
    
    //图标居中
    self.imageView.contentMode = UIViewContentModeCenter;
}

//原本要在此方法中设置自定义控件内的子控件的尺寸，但是本自定义控件的父类中有专门设置其内部子控件的尺寸的方法，所以要是再在这个方法里面设置子控件的尺寸的话就会擦除原来专门设置内部子控件的方法里面的代码，所以针对当前的这种情况，在此方法内什么也不写。
-(void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark ————— 重写设置按钮内部的label的位置的方法 —————
//contentRect参数是按钮自己的frame。
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:self.labelFont forKey:NSFontAttributeName];
    
    //通过label里面的文字算出label的宽度
    CGFloat labelW;
    
    /**
     "sizeWithFont:"方法在iOS7以后就被废弃了，取而代之的是"boundingRectWithSize:"方法，所以要对用户的手机系统先进行判断，然后才能确定使用何种方法了。但是老方法在iOS7以后也能使用，因为系统是向下兼容的，只是功能上没有新方法完善而已。
     */
    if (iOS7)  //iOS7及以上系统
    {
        
        /**
         boundingRectWithSize:方法只能在Xcode5.0版本以上的编辑器才能使用，Xcode5.0以下的编辑器运行的话会报错，要使Xcode5.0以下的编辑器运行的时候不编译这段代码，就要引入条件编译；
         条件编译：在文件中引入头文件<Availability.h>，里面定义了很多宏，这里写__IPHONE_7_0是指能开发出iOS7.0系统的对应的iOS SDK的版本所对应的开发工具Xcode的版本（Xcode5）；
         如果要调用的方法是可用的，就标示出它们首次可以用的所在Xcode的版本所对应的iOS SDK的版本所对应的手机iOS系统的版本。
         */
        
#ifdef __IPHONE_7_0  //只有Xcode在5.0以上的版本才会编译这一段代码，如果是低于Xcode5.0版本的编辑器则不编译这段代码。
        labelW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictionary context:nil].size.width;
#else  //Xcode4的编辑器写的代码，运行在iOS7.0及以上的系统的情况
        labelW = [self.currentTitle sizeWithFont:self.labelFont].width;
#endif
    }else  //iOS7以下的系统
    {
        labelW = [self.currentTitle sizeWithFont:self.titleLabel.font].width;
    }
    
    CGFloat labelH = contentRect.size.height;
    
    return CGRectMake(labelX, labelY, labelW, labelH);
}

#pragma mark ————— 重写设置按钮内部的imageView的位置的方法 —————
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 30;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = 0;
    CGFloat imageH = contentRect.size.height;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
