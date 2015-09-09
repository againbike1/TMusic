//
//  TAccountHeader.m
//  TMusic
//
//  Created by Leslie on 15/9/9.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TAccountHeader.h"

@implementation TAccountHeader

+(instancetype)accountHeaderView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"Account" owner:nil options:nil]lastObject];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
