//
//  NSString+StringTool.h
//  云图在线
//
//  Created by Jacky on 15/10/31.
//  Copyright © 2015年 Hydaya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringTool)
+ (NSString *)random32String;
+ (NSString *)getDateTimeToString;
+ (NSString *)md5: (NSString *)inPutText;
@end
