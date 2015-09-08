//
//  IWAccount.m
//  WeiBo17
//
//  Created by teacher on 15/8/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "TAccount.h"

@implementation TAccount

- (void)setAccess_token:(NSString*)access_token
{
    _access_token = access_token;
    self.createDate = [NSDate date];
}

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.remind_in forKey:@"remind_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeInteger:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.createDate forKey:@"createDate"];
}

- (instancetype)initWithCoder:(NSCoder*)decoder
{
    self = [super init];
    if (self) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_in = [decoder decodeIntegerForKey:@"expires_in"];
        self.createDate = [decoder decodeObjectForKey:@"createDate"];
    }
    return self;
}

@end
