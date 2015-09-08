//
//  TPlayFrame.h
//  TMusic
//
//  Created by Leslie on 15/8/31.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TPlayingFrame : NSObject

/** 播放进度视图 */
@property (nonatomic, assign) CGRect  topViewF;

/** 播放主视图 */
@property (nonatomic, assign) CGRect  playViewF;

/** 开始时间 */
@property (nonatomic, assign) CGRect  beginTimeLabelF;

/** 调整进度滑块 */
@property (nonatomic, assign) CGRect  playSliderBtnF;

/** 总时长 */
@property (nonatomic, assign) CGRect  endTimeLabelF;

/** 工具条 */
@property (nonatomic, assign) CGRect  toolsBtnF;

/** 专辑图片 */
@property (nonatomic, assign) CGRect  albumBgImageViewF;


@property (nonatomic, assign) CGRect  albumViewF;

/** 唱针 */
@property (nonatomic, assign) CGRect  playStylusImageViewF;

@property (nonatomic, assign) CGRect stylusBgViewF;

/** 引导背景的大图片 */
@property (nonatomic, assign) CGRect  smallGuideImageViewF;

/** 引导背景的小图片 */
@property (nonatomic, assign) CGRect  bigGuideImageViewF;

/** 左边的播放模式 */
@property (nonatomic, assign) CGRect  leftPlayModeBtnF;

/** 右边的播放模式 */
@property (nonatomic, assign) CGRect  rightPlayModeBtnF;

/** 上一曲 */
@property (nonatomic, assign) CGRect  lastMusicBtnF;

/** 播放/暂停 */
@property (nonatomic, assign) CGRect  playOrStopBtnF;

/** 下一曲 */
@property (nonatomic, assign) CGRect  nextMusicBtnF;

/** 音量背景视图 */
@property (nonatomic, assign) CGRect  volumeBgImageViewF;

/** 音量调节滑块 */
@property (nonatomic, assign) CGRect  volumeSliderF;

@property (nonatomic, assign) CGRect  marginLineF;

@end
