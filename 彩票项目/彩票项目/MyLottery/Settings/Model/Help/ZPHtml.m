//
//  ZPHtml.m
//  彩票项目
//
//  Created by apple on 16/8/11.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPHtml.h"

@implementation ZPHtml

#pragma mark ————— 使用普通方式封装对象的方法 —————
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.title = [dictionary objectForKey:@"title"];
        self.html = [dictionary objectForKey:@"html"];
        self.ID = [dictionary objectForKey:@"id"];
    }
    
    return self;
}

+ (instancetype)htmlWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

#pragma mark ————— 使用KVC方式封装对象的方法 —————
+ (instancetype)useKVCMethodPackagingObjectWithDict:(NSDictionary *)dict
{
    ZPHtml *html = [[ZPHtml alloc] init];
    
    [html setValuesForKeysWithDictionary:dict];
    
    return html;
}

/**
 使用KVC方式封装对象的话，必须要保证模型类里面的属性名与传入的字典参数里面的key完全相同。但有的时候字典参数里面的key是系统的关键字，不能直接作为模型类里面的属性的名称，所以就要用其他的属性名来代替，这个时候就要重写下面的系统方法，把新命名的属性名和原来字典参数里面的需要替换的key进行交换。
 */
- (void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"id"])
    {
        [self setValue:value forKey:@"ID"];
    }else
    {
        [super setValue:value forKey:key];
    }
}

@end
