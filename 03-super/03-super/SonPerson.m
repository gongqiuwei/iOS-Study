//
//  SonPerson.m
//  03-super
//
//  Created by gongqiuwei on 16/7/16.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "SonPerson.h"

@implementation SonPerson
- (void)test
{
    // 输出结果 SonPerson Person SonPerson
    // 参考 http://blog.jobbole.com/79588/
    // super是一个编译修饰符
//    NSLog(@"%@ %@ %@", [self class], [self superclass], [super class]);
    
    // 调用super的test方法，
    // 结果一样
    [super test];
}
@end
