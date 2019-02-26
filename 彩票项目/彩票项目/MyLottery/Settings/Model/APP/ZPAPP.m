//
//  ZPAPP.m
//  彩票项目
//
//  Created by apple on 16/8/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ZPAPP.h"

@implementation ZPAPP

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        self.icon = [dictionary objectForKey:@"icon"];
        self.title = [dictionary objectForKey:@"title"];
        self.scheme = [dictionary objectForKey:@"customUrl"];
        self.identifier = [dictionary objectForKey:@"id"];
        self.url = [dictionary objectForKey:@"url"];
    }
    
    return self;
}

+ (instancetype)appWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc] initWithDictionary:dictionary];
}

@end
