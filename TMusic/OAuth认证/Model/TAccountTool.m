//
//  IWAccountTool.m
//  WeiBo17
//
//  Created by teacher on 15/8/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "TAccountTool.h"
#import "TAccount.h"


#define ACCOUNT_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation TAccountTool


+ (void)saveAccount:(TAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:ACCOUNT_PATH];
}


+ (TAccount *)account{
    TAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ACCOUNT_PATH];
    
    if (!account) {
        return nil;
    }
    NSDate* date = [account.createDate dateByAddingTimeInterval:account.expires_in];
    NSDate* currentDate = [NSDate date];

    if ([currentDate compare:date] != NSOrderedAscending) {
   
        account = nil;
    }
    return account;
}


@end
