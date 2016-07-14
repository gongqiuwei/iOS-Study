//
//  Person.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/14.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Person.h"

@implementation Person

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
