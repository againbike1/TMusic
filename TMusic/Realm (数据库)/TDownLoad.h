//
//  TSearchSongs.h
//  TMusic
//
//  Created by Leslie on 15/9/7.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import <Realm/Realm.h>

@interface TDownLoad : RLMObject
@property NSString *songsName;
@property long long songsID;
@property NSString *songsAudio;
@property NSString *albumName;
@property long long albumID;
@property NSString *albumPicUrl;
@property NSString *artistName;
@property long long artistID;
@end


// This protocol enables typed collections. i.e.:
// RLMArray<TSearchSongs>
RLM_ARRAY_TYPE(TDownLoad)
