//
//  NSObject+Extension.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/14.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/message.h>

static const void *NameKey = "name";

@implementation NSObject (Extension)
- (void)setName:(NSString *)name
{
    // 添加属性,跟对象
    // 给某个对象产生关联,添加属性
    // object:给哪个对象添加属性
    // key:属性名,根据key去获取关联的对象 ,void * == id, OC对象或者C指针
    // value:关联的值
    // policy:存储策略、缓存策略
    objc_setAssociatedObject(self, NameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 也可以这样写
//    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name
{
    return objc_getAssociatedObject(self, NameKey);
}
@end
