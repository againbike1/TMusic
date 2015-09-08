//
//  TPlayingView.m
//  TMusic
//
//  Created by Leslie on 15/9/1.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TPlayingView.h"
#import "TPlayingFrame.h"
#import "TSearchSongsModel.h"
@interface TPlayingView ()
@end
@implementation TPlayingView
#pragma mark
#pragma mark View初始化
-(nonnull instancetype)initWithFrame:(CGRect)frame
{
    self                                            = [super initWithFrame:frame];
    if (self) {
    self.playingFrame                               = [[TPlayingFrame alloc]init];


        [self setUpTopView];
        [self setUpPlayingView];
        [self setUpPlayStylusView];

    }
    return self;
}

#pragma mark
#pragma mark 设置TopView
-(void)setUpTopView
{

    UIView *topView                                 = [[UIView alloc]init];
    topView.backgroundColor                         = [UIColor colorWithPatternImage:[UIImage imageNamed:@"time_picker_widget_header"]];
    [self addSubview:topView];
    self.topView                                    = topView;

    UIImageView *marginLineImageView                = [[UIImageView alloc]init];
    marginLineImageView.image                       = [UIImage imageNamed:@"playing_score_bg_shadow"];
    [topView addSubview:marginLineImageView];
    self.marginLineImageView                        = marginLineImageView;

    UILabel *beginTimeLabel                         = [[UILabel alloc]init];
    beginTimeLabel.textColor = [UIColor grayColor];
    beginTimeLabel.font = SYS_FONT(13);
    [topView addSubview:beginTimeLabel];
    self.beginTimeLabel                             = beginTimeLabel;

    UISlider *playSlider                            = [[UISlider alloc]init];
    [playSlider setThumbImage:[UIImage imageNamed:@"playing_control_time"] forState:UIControlStateNormal];
    UIImage * minImage                              = [self stretchableImageWithImageName:@"progressbar_time.9"];
    [playSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
    UIImage * maxImage                              = [self stretchableImageWithImageName:@"progressbar_time_bg.9"];
    [playSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [topView addSubview:playSlider];
    self.playSlider                                 = playSlider;

    UILabel *endTimeLabel                           = [[UILabel alloc]init];
    endTimeLabel.textColor = [UIColor grayColor];
    endTimeLabel.font = SYS_FONT(13);
    [topView addSubview:endTimeLabel];
    self.endTimeLabel                               = endTimeLabel;
}

#pragma mark
#pragma mark 设置唱针
-(void)setUpPlayStylusView
{
    UIView *stylusBgView = [[UIView alloc]init];
    [self.playingView addSubview:stylusBgView];
    self.stylusBgView = stylusBgView;

    UIImageView *bigGuideImageView                  = [[UIImageView alloc]init];
    bigGuideImageView.image                         = [UIImage imageNamed:@"playing_stylus_lp_bg"];
    [stylusBgView addSubview:bigGuideImageView];
    self.bigGuideImageView                          = bigGuideImageView;

    UIImageView *playStylusImageView                = [[UIImageView alloc]init];
    UIImage *playStylusImage                        = [UIImage imageNamed:@"playing_stylus_lp"];
    playStylusImage                                 = [playStylusImage stretchableImageWithLeftCapWidth:playStylusImage.size.width*0.5 topCapHeight:playStylusImage.size.height*0.5];
    playStylusImageView.image                       = playStylusImage;
    [bigGuideImageView addSubview:playStylusImageView];
    self.playStylusImageView                        = playStylusImageView;

    UIImageView *smallGuideImageView                = [[UIImageView alloc]init];
    smallGuideImageView.image                       = [UIImage imageNamed:@"playing_stylus_lp_top"];
    [bigGuideImageView addSubview:smallGuideImageView];
    self.smallGuideImageView                        = smallGuideImageView;

}


#pragma mark
#pragma mark 设置播放主界面
-(void)setUpPlayingView
{

    UIView *playingView                             = [[UIView alloc]init];
    playingView.backgroundColor                     = [UIColor colorWithPatternImage:[UIImage imageNamed:@"playing_bg_onepx.9"]];
    [self addSubview:playingView];
    self.playingView                                = playingView;
    
             [self setUpAlbumView];
    
    TPlayButton *leftPlayModeButton                 = [[TPlayButton alloc]init];
    [leftPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_cycle_off"] forState:UIControlStateNormal];
    [leftPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_cycle_on"] forState:UIControlStateSelected];
    [playingView addSubview:leftPlayModeButton];
    self.leftPlayModeButton                         = leftPlayModeButton;

    TPlayButton *rightPlayModeButton                = [[TPlayButton alloc]init];
    [rightPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_shuffle_off"] forState:UIControlStateNormal];
    [rightPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_shuffle_on"] forState:UIControlStateSelected];
    [playingView addSubview:rightPlayModeButton];
    self.rightPlayModeButton                        = rightPlayModeButton;

    TPlayButton *lastMusicButton                    = [[TPlayButton alloc]init];
    [lastMusicButton setImage:[UIImage imageNamed:@"btn_playing_prev"] forState:UIControlStateNormal];
    [lastMusicButton setImage:[UIImage imageNamed:@"btn_playing_prev_down"] forState:UIControlStateHighlighted];
    [playingView addSubview:lastMusicButton];
    self.lastMusicButton                            = lastMusicButton;

    TPlayButton *nextMusicButton                    = [[TPlayButton alloc]init];
    [nextMusicButton setImage:[UIImage imageNamed:@"btn_playing_next"] forState:UIControlStateNormal];
    [nextMusicButton setImage:[UIImage imageNamed:@"btn_playing_next_down"] forState:UIControlStateHighlighted];
    [playingView addSubview:nextMusicButton];
    self.nextMusicButton                            = nextMusicButton;


    UIImageView *volumeBgImageView                  = [[UIImageView alloc]init];
    UIImage *volumeBgImage                          = [UIImage imageNamed:@"progressbar_volume_bg.9"];
    volumeBgImage                                   = [volumeBgImage stretchableImageWithLeftCapWidth:volumeBgImage.size.width*0.5 topCapHeight:volumeBgImage.size.height*0.5];
    volumeBgImageView.image                         = volumeBgImage;
    [self addSubview:volumeBgImageView];
    self.volumeBgImageView                          = volumeBgImageView;

    UISlider *volumeSlider                          = [[UISlider alloc]init];
    [volumeSlider  setThumbImage:[UIImage imageNamed:@"playing_control_volume"] forState:UIControlStateNormal];
    UIImage *minImage                               = [self stretchableImageWithImageName:@"progressbar_volume.9"];
    [volumeSlider setMinimumTrackImage:minImage forState:UIControlStateNormal];
    UIImage *maxImage                               = [self stretchableImageWithImageName:@"progressbar_volume_bg.9"];
    [volumeSlider setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [volumeBgImageView addSubview:volumeSlider];
    self.volumeSlider                               = volumeSlider;

}

- (UIImage *)stretchableImageWithImageName :(NSString *)name;
{
    UIImage *image                                  = [UIImage imageNamed:name];

    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
}

#pragma mark
#pragma mark 设置专辑
- (void)setUpAlbumView
{
    UIView *albumView                               = [[UIView alloc]init];
    [self.playingView addSubview:albumView];
    self.albumView                                  = albumView;

    UIImageView *albumImageView                     = [[UIImageView alloc]init];
    [albumView addSubview:albumImageView];
    self.albumImageView                             = albumImageView;

    UIImageView *albumBgImageView                   = [[UIImageView alloc]init];
    albumBgImageView.image                          = [UIImage imageNamed:@"playing_lp"];
    [albumView addSubview:albumBgImageView];
    self.albumBgImageView                           = albumBgImageView;

    UIButton *stopButton                            = [[UIButton alloc]init];
    [stopButton setImage:[UIImage imageNamed:@"btn_playing_play"] forState:UIControlStateNormal];
    [stopButton setImage:[UIImage imageNamed:@"btn_playing_play_down"] forState:UIControlStateHighlighted];
    [self.playingView addSubview:stopButton];
    self.stopButton                                 = stopButton;
    
    
    TPlayButton *toolsButton                        = [[TPlayButton alloc]init];
    [toolsButton setBackgroundImage:[UIImage imageNamed:@"btn_unbrella_down"] forState:UIControlStateNormal];
        [toolsButton setBackgroundImage:[UIImage imageNamed:@"btn_unbrella"] forState:UIControlStateHighlighted];
    [toolsButton setImage:[UIImage imageNamed:@"btn_unbrella_icon0"] forState:UIControlStateNormal];
    
    [self.playingView addSubview:toolsButton];
    self.toolsButton                                = toolsButton;

}


#pragma mark
#pragma mark 设置frame
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.topView.frame                              = self.playingFrame.topViewF;
    self.playingView.frame                          = self.playingFrame.playViewF;

    self.beginTimeLabel.frame                       = self.playingFrame.beginTimeLabelF;
    self.endTimeLabel.frame                         = self.playingFrame.endTimeLabelF;
    self.playSlider.frame                           = self.playingFrame.playSliderBtnF;

    self.toolsButton.frame                          = self.playingFrame.toolsBtnF;

    self.albumView.frame                            = self.playingFrame.albumViewF;
    self.albumBgImageView.frame                     = self.playingFrame.albumBgImageViewF;
    CGFloat albumImageViewWH                        = SCREEN_W*0.4;
    self.albumImageView.size                        = CGSizeMake(albumImageViewWH, albumImageViewWH);
    self.albumImageView.center                      = self.albumView.center;
    self.stylusBgView.frame = self.playingFrame.stylusBgViewF;
    self.bigGuideImageView.frame                    = self.playingFrame.bigGuideImageViewF;
    self.smallGuideImageView.frame                  = self.playingFrame.smallGuideImageViewF;
    self.playStylusImageView.frame                  = self.playingFrame.playStylusImageViewF;

    self.leftPlayModeButton.frame                   = self.playingFrame.leftPlayModeBtnF;
    self.rightPlayModeButton.frame                  = self.playingFrame.rightPlayModeBtnF;

    self.stopButton.frame                           = self.playingFrame.playOrStopBtnF;
    self.lastMusicButton.frame                      = self.playingFrame.lastMusicBtnF;
    self.nextMusicButton.frame                      = self.playingFrame.nextMusicBtnF;

    self.volumeBgImageView.frame                    = self.playingFrame.volumeBgImageViewF;
    self.volumeSlider.frame                         = self.playingFrame.volumeSliderF;

    self.marginLineImageView.frame                  = self.playingFrame.marginLineF;
//    NSLog(@"%@",NSStringFromCGRect(self.playSlider.frame));
   
}

#pragma mark
#pragma mark 播放按钮点击


#pragma mark

@end
