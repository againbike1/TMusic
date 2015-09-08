//
//  TPlayModel.h
//  TMusic
//
//  Created by Leslie on 15/8/30.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSearchSongsModel.h"
@interface TSearchModel : NSObject
@property (nonatomic, copy) NSString *songCount;
@property (nonatomic, copy) TSearchSongsModel *songs;



@end
