//
//  UIBarButtonItem+Extension.h
//  LSWeiBo
//
//  Created by Leslie on 15/8/16.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName :(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

+ (instancetype)itemWithImageName :(NSString *)imageName  target:(id)target action:(SEL)action;
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action;
@end
