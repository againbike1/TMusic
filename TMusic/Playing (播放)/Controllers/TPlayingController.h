//
//  TPlayingViewController.h
//  TMusic
//
//  Created by Leslie on 15/9/1.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STKAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TDownLoad.h"
@class TSearchSongsModel;
@class TDownLoad;
@interface Collect :RLMObject

@property long long collectSongsID;
@end
@interface TPlayingController : UIViewController

@property (nonatomic, strong) TDownLoad *downLoadModel;
@property(nonatomic,assign)BOOL isDownLoadMusic;
@property(nonatomic,strong)STKAudioPlayer *player;
@property (nonatomic, strong) TSearchSongsModel *songsModel;
@property(nonatomic,assign)BOOL isSearchMusic;
@property (strong, nonatomic) AVAudioPlayer *downloadPlayer;

+(TPlayingController *)sharePlayingVc;


@end
