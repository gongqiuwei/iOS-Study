//
//  Person.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/14.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Person.h"
#import <objc/message.h>

@implementation Person

void say(id self, SEL _cmd, id param1)
{
    NSLog(@"%@ %@ %@", self, NSStringFromSelector(_cmd), param1);
}

// OC中默认一个方法都有两个参数,self,_cmd,隐式参数
// self:方法调用者
// _cmd:调用方法的编号

// 动态添加方法,首先实现这个resolveInstanceMethod
// resolveInstanceMethod调用:当调用了没有实现的方法没有实现就会调用resolveInstanceMethod
// resolveInstanceMethod作用:就知道哪些方法没有实现,从而动态添加方法
// sel:没有实现方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(say:)) {
        
        // 动态添加方法
        /*
         cls:给哪个类添加方法
         SEL:添加方法的方法编号是什么
         IMP:方法实现,函数入口,函数名
         types:方法类型（document中搜runtime找到runtime functions-> 
                message forwardings -> types encoding里面规定好了 v代表void @代表对象 :代表SEL等等）
         */
        class_addMethod([self class], sel, (IMP)say, "v@:@");
        
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(say:)) {
        
        // 给类添加方法
        // 需要添加到metaClass上
        // 解释blog：http://chun.tips/blog/2014/11/05/bao-gen-wen-di-objective[nil]c-runtime-(2)[nil]-object-and-class-and-meta-class/
        class_addMethod( objc_getMetaClass(class_getName(self)), sel, (IMP)say, "v@:@");
        return YES;
    }
    
    return [super resolveClassMethod:sel];
}

- (void)run:(int)no
{
    NSLog(@"run:%d", no);
}

- (void)eat
{
    NSLog(@"对象方法-----eat");
}


+ (void)eat
{
    NSLog(@"类方法-----eat");
}
@end
