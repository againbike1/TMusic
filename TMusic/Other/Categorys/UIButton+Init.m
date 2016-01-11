//
//  UIButton+Init.m
//  
//
//  Created by jacky on 15/10/8.
//
//

#import "UIButton+Init.h"

@implementation UIButton (Init)


+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(CGFloat )font
{
    UIButton *button = [[UIButton alloc]init];
    [button setBackgroundColor:RandomColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button.titleLabel setFont:SYS_FONT(font)];
    return button;
}

@end
