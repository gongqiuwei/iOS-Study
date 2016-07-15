//
//  Status.h
//  02-runtime
//
//  Created by gongqiuwei on 16/7/15.
//  Copyright © 2016年 gongqiuwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

@interface Status : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, strong) NSString *source;

@property (nonatomic, assign) NSInteger reposts_count;

@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) NSString *created_at;

@property (nonatomic, assign) int attitudes_count;

@property (nonatomic, strong) NSString *idstr;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) int comments_count;

//@property (nonatomic, strong) NSDictionary *user;
@property (nonatomic, strong) User *user;

//@property (nonatomic, strong) NSDictionary *retweeted_status;
@property (nonatomic, strong) Status *retweeted_status;


// 使用KVC做字典与模型的转换
+ (__kindof Status *)statusWithDict:(NSDictionary *)dict;
@end
