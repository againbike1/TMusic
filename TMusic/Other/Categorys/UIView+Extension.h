//
//  UIView+Extension.h
//  LSWeiBo
//
//  Created by jacky on 15/8/16.
//  Copyright (c) 2015年 贾克奇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner;

//  the view must not have any connecting to the file owner
+ (id)loadViewFromXibNamed:(NSString*)xibName;

+ (CGSize)textSize:(NSString *)text maxSize:(CGSize )maxtextSize font:(UIFont *)font;

+ (UIViewController *)getCurrentVC;

@end
