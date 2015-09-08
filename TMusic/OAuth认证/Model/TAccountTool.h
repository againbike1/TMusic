//
//  IWAccountTool.h
//  WeiBo17
//
//  Created by teacher on 15/8/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TAccount;

@interface TAccountTool : NSObject


+ (void)saveAccount:(TAccount *)account;

+ (TAccount *)account;

@end
