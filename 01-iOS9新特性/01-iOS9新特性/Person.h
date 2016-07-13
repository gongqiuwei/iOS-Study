//
//  Person.h
//  01-iOS9新特性
//
//  Created by gongqiuwei on 16/7/13.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

// 自定义泛型
// 申明一个泛型的类型
// 表示在创建对象的时候需要声明一个ObjectType的类型，如果定义的时候不说明，那么就是id类型
// 根据ObjectType来确定属性的类型，或者方法的返回值，或者需要传入的参数类型等等，比以前只说明为id的情况强了许多，减少了很多不确定性
@interface Person<__covariant ObjectType> : NSObject

// 使用什么语言不确定，因此在这里使用泛型的类型
@property (nonatomic, strong) ObjectType language;
- (ObjectType)languageForPerson;
- (void)setLanguageToPerson:(ObjectType)language;

// 使用泛型
// 表明集合内部装的对象的类型是NSString *
// 存取的时候都确定好了类型，不在是以前的id了
@property (nonatomic, strong) NSMutableArray<NSString *> *names;
@end
