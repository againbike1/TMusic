//
//  TSongsListHeader.m
//  TMusic
//
//  Created by Leslie on 15/9/4.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TSongsListHeader.h"

@implementation TSongsListHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label = [[UILabel alloc]init];
        label.font = SYS_FONT(13);
        label.textColor = [UIColor grayColor];
        [self addSubview:label];
        self.label =label;
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.label.height = self.height;
    self.label.width = SCREEN_W*0.5;
}
@end
