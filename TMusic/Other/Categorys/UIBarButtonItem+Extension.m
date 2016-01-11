//
//  UIBarButtonItem+Extension.m
//  LSWeiBo
//
//  Created by Leslie on 15/8/16.
//  Copyright (c) 2015年 贾克奇. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (instancetype)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button  = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    NSString *seletedName = [NSString stringWithFormat:@"%@_highlighted",imageName];
    [button setImage:[UIImage imageNamed:seletedName] forState:UIControlStateHighlighted];
    button.size =button.currentImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (instancetype)itemWithImageName:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *button  = [[UIButton alloc]init];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    NSString *seletedName = [NSString stringWithFormat:@"%@_highlighted",imageName];
    [button setImage:[UIImage imageNamed:seletedName] forState:UIControlStateSelected];
    button.titleLabel.text = title;
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIButton *button = [[UIButton alloc] init];
    
    //设置title
    [button setTitle:title forState:UIControlStateNormal];
    
    //设置title不同状态的颜色
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    //根据内容调整大小
    [button sizeToFit];
    
    //添加点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
    
}
@end
