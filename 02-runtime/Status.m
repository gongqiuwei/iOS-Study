//
//  Status.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/15.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "Status.h"

@implementation Status
+ (__kindof Status *)statusWithDict:(NSDictionary *)dict
{
    Status *status = [[self alloc] init];
    
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}

// KVC字典转模型弊端：必须保证，模型中的属性和字典中的key一一对应。
// 如果字典中的key在模型中到不到，就会调用这个方法，覆盖这个方法就能处理这种情况
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // 处理字典中的key， model中没有定义
    // 例如
    if ([key isEqualToString:@"id"]) {
        _ID = [value integerValue];
    }
}
@end
