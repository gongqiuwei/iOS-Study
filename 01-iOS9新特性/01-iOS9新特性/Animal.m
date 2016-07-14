//
//  Animal.m
//  01-iOS9新特性
//
//  Created by gongqiuwei on 16/7/13.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Animal.h"

@implementation Animal
+ (__kindof Animal *)animal
{
    return [[self alloc] init];
}
@end
