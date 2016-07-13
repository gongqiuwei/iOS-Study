//
//  ViewController.m
//  01-iOS9新特性
//
//  Created by gongqiuwei on 16/7/13.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

#warning 关键字只是做提示使用，提高程序员的交流，如果不符合规范编译只会报警，并不会报错
// nullalbe 可以为空
//@property (nonatomic, strong, nullable) NSString *p1;
//@property (nonatomic, strong) NSString * _Nullable p1;
@property (nonatomic, strong) NSString *__nullable p1;
//- (nullable NSString *)testP1:( NSString *_Nullable)str;

// nonnull 不能为空
//@property (nonatomic, strong, nonnull) NSString *p2;
//@property (nonatomic, strong) NSString *__nonnull p2;
@property (nonatomic, strong) NSString *_Nonnull p2;
//- (nonnull NSString *)testP2:( NSString *_Nonnull)str;

// 宏 在NS_ASSUME_NONNULL_BEGIN和NS_ASSUME_NONNULL_END之间,定义的所有对象属性和方法默认都是nonnull
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, strong) NSString *p3;
//- (NSString *)testP3:(NSString *)str;
NS_ASSUME_NONNULL_END

// null_resettable：表示get:不能返回为空, set可以为空
// 必须 重写get方法或者set方法,处理传递的值为空的情况
@property (nonatomic, strong, null_resettable) NSString *p4;
// 只能用于对象属性
//@property (nonatomic, assign, null_resettable) BOOL aaa;
@end

@implementation ViewController

// 重写setter方法
//- (void)setP4:(NSString *)p4
//{
//    if (p4 == nil) {
//        p4 = @"default";
//    }
//    
//    _p4 = p4;
//}

// 重写getter
- (NSString *)p4
{
    if (_p4 == nil) {
        // 给定一个初始值
        _p4 = @"default";
    }
    return _p4;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.p1 = nil;
//    [self testP1:nil];
    
    // 只是警告
    self.p3 = nil;
    
//    [self testP3:@"111"];
}

@end
