//
//  NSDictionary+String.h
//  云图在线
//
//  Created by Jacky on 15/10/19.
//  Copyright (c) 2015年 Hydaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (String)
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (NSString *)dictionaryToJson:(NSDictionary *)dic;

@end
