//
//  TPlayAlbumModel.m
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TSearchAlbumModel.h"

@implementation TSearchAlbumModel
-(instancetype)initWithAlbumPlayDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)searchAlbumWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithAlbumPlayDict:dict];
}

@end
