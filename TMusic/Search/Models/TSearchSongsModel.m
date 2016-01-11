//
//  TPlaySongsModel.m
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TSearchSongsModel.h"

@implementation TSearchSongsModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)searchSongsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}
@end
