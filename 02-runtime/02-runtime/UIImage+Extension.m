//
//  UIImage+Extension.m
//  02-runtime
//
//  Created by gongqiuwei on 16/7/14.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import "UIImage+Extension.h"
#import <objc/message.h>

@implementation UIImage (Extension)

// 分类的load方法和原来的类UIImage的方法不是同一个
+ (void)load
{
//    NSLog(@"%s", __func__);
    
    // 交换系统方法和自定义方法的实现方式
    // class_getClassMethod 获取类方法
    // class_getInstanceMethod 获取对象方法
    Method sysMethod = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method extensionMethod = class_getClassMethod([UIImage class], @selector(gw_imageNamed:));
    method_exchangeImplementations(sysMethod, extensionMethod);
}

+ (__kindof UIImage *)gw_imageNamed:(NSString *)imageName
{
    // 分类加载进来的时候，就将imageNamed: 和 gw_imageNamed: 2个方法的实现方式交换了，如果在这里调用imageNamed: 方法，它其实是掉到这里来的，会导致死循环
//    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *image = [UIImage gw_imageNamed:imageName];
    
    if (image == nil) {
        NSLog(@"加载图片为空");
    }
    
    return image;
}

@end
