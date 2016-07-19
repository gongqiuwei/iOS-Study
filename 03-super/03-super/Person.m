//
//  Person.m
//  03-super
//
//  Created by gongqiuwei on 16/7/16.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Person.h"

@implementation Person
- (void)test
{
    NSLog(@"%@ %@ %@", [self class], [self superclass], [super class]);
}
@end
