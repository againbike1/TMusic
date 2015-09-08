//
//  IWAccount.h
//  WeiBo17
//
//  Created by teacher on 15/8/19.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAccount : NSObject <NSCoding>


@property (nonatomic, copy) NSString* access_token;

@property (nonatomic, assign) NSInteger expires_in;

@property (nonatomic, copy) NSString* remind_in;

@property (nonatomic, copy) NSString* uid;

@property (nonatomic, strong) NSDate* createDate;

@end
