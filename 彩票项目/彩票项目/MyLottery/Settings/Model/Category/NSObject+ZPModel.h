//
//  NSObject+ZPModel.h
//  彩票项目
//
//  Created by 赵鹏 on 2019/2/2.
//  Copyright © 2019 apple. All rights reserved.
//

/**
 使用运行时方式封装对象类。
 
 封装对象有三种方式：
 1、使用普通方式封装对象；
 2、使用KVC方式封装对象；
 3、使用运行时方式封装对象。
 前两种方式参考"ZPHtml"类，第三种方式参考本类。
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZPModel)

+ (instancetype)useRuntimeMethodPackagingObjectWithDict:(NSDictionary *)dict mapDict:(NSDictionary *)mapDict;

@end

NS_ASSUME_NONNULL_END
