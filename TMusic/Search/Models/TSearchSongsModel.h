//
//  TPlaySongsModel.h
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSearchAlbumModel.h"
@interface TSearchSongsModel : NSObject
@property (nonatomic, strong) TSearchAlbumModel *album;
@property (nonatomic, strong) TSearchArtistsModel *artists;
@property (nonatomic, copy) NSString *audio;
@property (nonatomic, assign) long long id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *djProgramId;

-(instancetype)initWithDict :(NSDictionary *)dict;
+(instancetype)searchSongsWithDict :(NSDictionary *)dict;
@end
