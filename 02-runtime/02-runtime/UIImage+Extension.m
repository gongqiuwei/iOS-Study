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
/*
 大神推荐的方法交换的做法 Method Swizzling
 http://southpeak.github.io/blog/2014/11/06/objective-c-runtime-yun-xing-shi-zhi-si-:method-swizzling/
 */

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        Class class = [self class];
        Class class = object_getClass((id)self);
        
        SEL originalSel = @selector(imageNamed:);
        SEL swizzledSel = @selector(gw_imageNamed:);
        
        // 注册一个方法（Method），它的SEL是originalSel, 实现方式是swizzledSel的IMP
//        Method originalM = class_getClassMethod(class, originalSel);
//        Method swizzleM = class_getClassMethod(class, swizzledSel);
        Method originalM = class_getInstanceMethod(class, originalSel);
        Method swizzleM = class_getInstanceMethod(class, swizzledSel);
        
        
        /*
         * @note class_addMethod will add an override of a superclass's implementation,
         *  but will not replace an existing implementation in this class.
         *  To change an existing implementation, use method_setImplementation.
         
         对于当前类已经实现了的方法，class_addMethod是不会成功的，如果当前类没有实现该方法，那么class_addMethod会增加实现IMP
         
         */
        BOOL didAddMethod = class_addMethod(class, originalSel, method_getImplementation(swizzleM), method_getTypeEncoding(swizzleM));
        
        if (didAddMethod) {
            
            // 替换实现方式
            // 将swizzledSel的实现方式(IMP)替换成originalSel的IMP
            // 这样 originalSel的IMP是swizzledsel的IMP
            // swizzledsel的IMP是 originalSel原来的IMP，实现了方法交换
            class_replaceMethod(class, swizzledSel, method_getImplementation(originalM), method_getTypeEncoding(originalM));
        } else {
            method_exchangeImplementations(originalM, swizzleM);
        }
    });
}


/*
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
 */


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
