//
//  NSObject+Model.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/15.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "NSObject+Model.h"
#import <objc/message.h>

// 利用runtime实现字典->模型
@implementation NSObject (Model)

// 一级字典转换
+ (instancetype)createObjectWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    // 获取ivar变量
    // 注意 @property 申明的变量与 Ivar变量 不是一个概念
    // Ivar变量 是类的实例变量
    // @property 这个关键字，编译器在后台做了三件事：申明一个 _开始的实例变量， 申明getter与setter方法、实现getter与setter方法
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        // 取出变量
        Ivar ivar = ivarList[i];
        
        // ivarName: _attitudes_count 带下划线开始的，需要做处理，不然从dict中取不到值
        NSString *propertyName = [[NSString stringWithUTF8String:ivar_getName(ivar)] substringFromIndex:1];
//        NSLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
//        NSLog(@"%@", propertyName);
        
        // 使用KVC给对应的propertyName赋值
        if (dict[propertyName]) {
            [obj setValue:dict[propertyName] forKey:propertyName];
        }
    }
    
    // 由于runtime是比较底层的API，ARC不会帮助管理，CoreFundation里面的对象也是如此
    // 记住要释放，否则会造成内存泄露
    free(ivarList);
    
    return obj;
}

// 二级转换
+ (instancetype)objectWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 属性名
        NSString *propertyName = [[NSString stringWithUTF8String:ivar_getName(ivar)] substringFromIndex:1];
        
        // 属性类型
        NSString *properType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        // source, @"NSString"
//        NSLog(@"%@, %@", propertyName, properType);
        
        id value = [dict valueForKey:propertyName];
        
        // 有的属性model中定义了，但是dict中不一定有，那么直接返回
        if (value == nil) continue;
        
        // dict中取出的值为字典，并且在model中定义的属性类型为User或者其他自定义的model类的时候才需要做二级转换
        // 断点调试 当为字典的时候 properType的值为 @"@\"NSDictionary\"", 不要被NSLog输出所欺骗
        if ([value isKindOfClass:[NSDictionary class]] && ![properType containsString:@"@\"NS"]) {
            // 假定 对User类做二级转换
            // 获取类名
            // properType 为  @"@\"User\"" 需要截取字符串
//            NSLog(@"%@", properType);
//            NSLog(@"%@", [properType substringToIndex:1]);
//            NSLog(@"%@", [properType substringToIndex:2]);
//            NSLog(@"%@", [properType substringToIndex:3]);
            // 通过上面的打印可以看出，\" 是占一个位置的，\只是辅助输出作用，不占内存
            // 因此 @" 前面有2个， 最后 " 占一个，所以可以使用下面的方式取得类名
            NSString *className = [properType substringWithRange:NSMakeRange(2, properType.length-3)];
//            NSLog(@"%@", className);
            
            Class modelClass = NSClassFromString(className);
            if (modelClass) {
                // 递归调用，
                id subObj = [modelClass objectWithDict:value];
                
                [obj setValue:subObj forKey:propertyName];
            }
        } else {
            
            // 不需要做二级转换直接设置值
            [obj setValue:value forKey:propertyName];
        }
    }
    
    free(ivarList);
    
    return obj;
}

@end
