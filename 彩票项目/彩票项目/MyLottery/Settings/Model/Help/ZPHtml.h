//
//  ZPHtml.h
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

//帮助视图控制中的每行cell对应的对象类。

#import <Foundation/Foundation.h>

@interface ZPHtml : NSObject

@property (nonatomic, copy) NSString *title;  //网页的标题
@property (nonatomic, copy) NSString *html;  //网页的文件名
@property (nonatomic, copy) NSString *ID;  //网页的标签

//使用普通方式封装对象的方法
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)htmlWithDictionary:(NSDictionary *)dictionary;

//使用KVC方式封装对象的方法
+ (instancetype)useKVCMethodPackagingObjectWithDict:(NSDictionary *)dict;

@end
