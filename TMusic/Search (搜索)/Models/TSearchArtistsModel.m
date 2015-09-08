//
//  TPlayArtistsModel.m
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TSearchArtistsModel.h"

@implementation TSearchArtistsModel
-(instancetype)initWithArtistsDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)searchArtistsWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithArtistsDict:dict];
}
@end
