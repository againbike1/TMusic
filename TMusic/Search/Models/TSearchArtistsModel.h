//
//  TPlayArtistsModel.h
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSearchArtistsModel : NSObject
@property (nonatomic, assign) long long id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;


-(instancetype)initWithArtistsDict :(NSDictionary *)dict;
+(instancetype)searchArtistsWithDict :(NSDictionary *)dict;

@end
