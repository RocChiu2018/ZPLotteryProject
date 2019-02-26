//
//  ZPAPP.h
//  彩票项目
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

//产品推荐视图控制器里面的每个item所对应的对象类。

#import <Foundation/Foundation.h>

@interface ZPAPP : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *scheme;  //如果本机上有要跳转到的项目的话，则此为要跳转到的项目的协议名
@property (nonatomic, copy) NSString *identifier;  //如果本机上有要跳转到的项目的话，则此为要跳转到的项目的协议名后面的路径名
@property (nonatomic, copy) NSString *url;  //如果本机上没有要跳转到的项目的话，就直接跳转到APP Store上此项目对应的下载页面，提供下载。这个是APP Store下载页面的路径。

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

+ (instancetype)appWithDictionary:(NSDictionary *)dictionary;

@end
