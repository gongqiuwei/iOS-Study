//
//  NSObject+Model.h
//  02-runtime
//
//  Created by gongqiuwei on 16/7/15.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

// 一级转换
+ (instancetype)createObjectWithDict:(NSDictionary *)dict;

// 二级转换
+ (instancetype)objectWithDict:(NSDictionary *)dict;
@end
