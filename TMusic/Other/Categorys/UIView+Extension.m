//
//  UIView+Extension.m
//  LSWeiBo
//
//  Created by Leslie on 15/8/16.
//  Copyright (c) 2015年 贾克奇. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//**********************************//
- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame  = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

//**********************************//
- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame  = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

//**********************************//
- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame  = rect;
}

- (CGFloat)width
{
    return self.frame.size.width;
}


//**********************************//
- (void)setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame  = rect;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


//**********************************//
- (void)setSize:(CGSize)size
{
    CGRect rect = self.frame;
    rect.size = size;
    self.frame  = rect;
}

- (CGSize)size
{
    return self.frame.size;
}


//**********************************//
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center  = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}


//**********************************//
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center  = center;
}


- (CGFloat)centerY
{
    return self.center.y;
}
//**********************************//

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    }else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName {
    return [UIView loadViewFromXibNamed:xibName withFileOwner:self];
}


+ (CGSize)textSize:(NSString *)text maxSize:(CGSize )maxtextSize font:(UIFont *)font{
    
    NSDictionary *dict = @{NSFontAttributeName:font};
    return  [text boundingRectWithSize:maxtextSize options: NSStringDrawingUsesLineFragmentOrigin attributes:dict    context:nil].size;
}

+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


@end
