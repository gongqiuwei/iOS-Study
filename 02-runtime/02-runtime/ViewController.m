//
//  ViewController.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/14.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "NSObject+Extension.h"
#import "NSObject+Model.h"
#import "Status.h"
#import "User.h"
#import <objc/message.h>

// 使用runtime
// 1.导入<objc/message.h> <objc/runtime.h>
// 2.build setting -> 搜索msg -> 设定为NO

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *dictArr = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil]][@"statuses"];
    
    NSMutableArray *statuses = [NSMutableArray array];
    for (NSDictionary *dict in dictArr) {
        
        // KVC字典转模型
//        Status *status = [Status statusWithDict:dict];
        
        // runtime字典转模型 一级转换
//        Status *status = [Status createObjectWithDict:dict];
        
        // runtime字典转模型 二级转换
        Status *status = [Status objectWithDict:dict];
        
        NSLog(@"%@", status.user.profile_image_url);
        [statuses addObject:status];
    }
    
//    NSLog(@"%@", statuses);
}

// 4、动态添加属性
- (void)testAddProperty
{
    NSObject *obj = [[NSObject alloc] init];
    obj.name = @"123";
    NSLog(@"%@", obj.name);
}

// 3、动态添加方法
- (void)testAddMethod
{
    // 执行为定义的对象方法
    [[Person alloc] performSelector:@selector(say:) withObject:@"hello"];
    
    // 未定义的类方法
    [Person say:@"1111"];
}


// 2、方法交换
- (void)testMethodChange
{
    // 方法交换
    // 需求：给imageNamed方法提供功能，每次加载图片就判断下图片是否加载成功。
    // 步骤一：先搞个分类，定义一个能加载图片并且能打印的方法+ (instancetype)imageWithName:(NSString *)name;
    // 步骤二：交换imageNamed和imageWithName的实现，就能调用imageWithName，间接调用imageWithName的实现。
    // 不能在分类中重写系统方法imageNamed，因为会把系统的功能给覆盖掉，而且分类中不能调用super.
    // 使用runtime将系统方法的实现方式和自己定义的方法的实现方式进行交换
    [UIImage imageNamed:@"123"];
}

// 1、消息发送
- (void)testMsgSend
{
    // 对象方法调用
    Person *p = [[Person alloc] init];
    objc_msgSend(p, @selector(eat));
    objc_msgSend(p, @selector(run:), 10);
    
    // 类方法调用
    Class pClass = [Person class];
    objc_msgSend(pClass, @selector(eat));
}

@end
