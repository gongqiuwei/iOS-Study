//
//  Using.m
//  01-iOS9新特性
//
//  Created by gongqiuwei on 16/7/13.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Using.h"

#import "Person.h"
#import "IOS.h"
#import "JAVA.h"
#import "Language.h"

@implementation Using

- (void)test
{
    // 如果定义的时候不指定类型，表示是id类型
    Person *p1 = [[Person alloc] init];
    p1.language = @"1111";
    
    Person<IOS *> *p2 = [[Person alloc] init];
    p2.language = [[IOS alloc] init];
    // 会报错，表示lanuage的类型需要时IOS *类型的
//    p2.language = @"1111";
    // 返回的数据类型是IOS *
    [p2 languageForPerson];
    [p2 setLanguageToPerson:[[IOS alloc] init]];
    
    
    // 协变性
    // p3的类型 Person<Language *>
    // p4的类型 Person<JAVA *>
    // 2个person的泛型不一样，因此相互赋值的时候回产生警告，因此，有协变性和逆变性的关键字
    Person<Language *> *p3 = [[Person alloc] init];
    Person<JAVA *> *p4 = p3;
    
    [p4 languageForPerson];
}
@end
