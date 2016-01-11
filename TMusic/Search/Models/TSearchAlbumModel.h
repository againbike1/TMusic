//
//  TPlayAlbumModel.h
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSearchArtistsModel.h"
@interface TSearchAlbumModel : NSObject
@property (nonatomic, assign) long long  id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picUrl;
@property (nonatomic, strong) TSearchArtistsModel *artist;

-(instancetype)initWithAlbumPlayDict :(NSDictionary *)dict;
+(instancetype)searchAlbumWithDict :(NSDictionary *)dict;

@end
