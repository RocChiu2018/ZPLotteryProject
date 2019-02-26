//
//  ZPCollectionViewCell.h
//  彩票项目
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

//产品推荐视图控制器中的每个item所对应的视图类。

#import <UIKit/UIKit.h>

@class ZPAPP;

@interface ZPCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ZPAPP *app;

@end
