//
//  NSString+StringTool.m
//  云图在线
//
//  Created by Jacky on 15/10/31.
//  Copyright © 2015年 Hydaya. All rights reserved.
//

#import "NSString+StringTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (StringTool)
+(NSString *)random32String
{
    int NUMBER_OF_CHARS = 32;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x<NUMBER_OF_CHARS;data[x++] = (char)('a' + (arc4random_uniform(26))));
    return [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
}

+ (NSString *)getDateTimeToString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd/HH:mm"];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    return dateString;
}

+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_LONG cStrlength = (CC_LONG)strlen(cStr);
    CC_MD5(cStr, cStrlength, result);
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
