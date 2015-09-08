//
//  TPlayingView.h
//  TMusic
//
//  Created by Leslie on 15/9/1.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPlayingFrame;
@interface TPlayingView : UIView

@property (nonatomic, strong) TPlayingFrame *playingFrame;

@property (nonatomic, strong) UIView        *topView;

@property (nonatomic, strong) UIView        *playingView;

@property (nonatomic, strong) UILabel       *beginTimeLabel;

@property (nonatomic, strong) UILabel       *endTimeLabel;

@property (nonatomic, strong) UISlider      *playSlider;

@property (nonatomic, strong) TPlayButton   *toolsButton;

@property (nonatomic, strong) UIImageView   *albumImageView;

@property (nonatomic, strong) UIView        *albumView;

@property (nonatomic, strong) UIImageView   *albumBgImageView;

@property (nonatomic, strong) UIImageView   *playStylusImageView;

@property (nonatomic, strong) UIImageView   *smallGuideImageView;

@property (nonatomic, strong) UIImageView   *bigGuideImageView;

@property (nonatomic, strong) UIView *stylusBgView;

@property (nonatomic, strong) TPlayButton   *leftPlayModeButton;

@property (nonatomic, strong) TPlayButton   *rightPlayModeButton;

@property (nonatomic, strong) UIButton      *stopButton;

@property (nonatomic, strong) TPlayButton   *lastMusicButton;

@property (nonatomic, strong) TPlayButton   *nextMusicButton;

@property (nonatomic, strong) UIImageView   *volumeBgImageView;

@property (nonatomic, strong) UISlider      *volumeSlider;

@property (nonatomic, strong) UIImageView   *marginLineImageView;
@end
