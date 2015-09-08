//
//  TPlayFrame.m
//  TMusic
//
//  Created by Leslie on 15/8/31.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TPlayingFrame.h"

@implementation TPlayingFrame

-(instancetype)init
{
    self                     = [super init];

    if (self) {
    CGFloat topViewH         = 44;
    _topViewF                = CGRectMake(0,0, SCREEN_W, topViewH);

    CGFloat playViewH        = SCREEN_H - topViewH;
    CGFloat playViewY        = CGRectGetMaxY(_topViewF);
    _playViewF               = CGRectMake(0,playViewY, SCREEN_W, playViewH);

    CGFloat MarginLineH      = 1;
    CGFloat marginLineY      = 40;
    _marginLineF             = CGRectMake(0, marginLineY, SCREEN_W, MarginLineH);

    CGFloat beginTimeW       = 35;
    CGFloat beginTimeH       = topViewH;
    CGFloat beginTimeY       = topViewH*0.5 - beginTimeH*0.5;
    _beginTimeLabelF         = CGRectMake(MARGIN*0.5, beginTimeY, beginTimeW, beginTimeH);

    CGFloat playSliderW     = SCREEN_W - 2*beginTimeW- MARGIN;
    CGFloat playSliderH     = topViewH;
    CGFloat playSliderX     = SCREEN_W*0.5 - playSliderW*0.5;
    CGFloat playSliderY     = 0;
    _playSliderBtnF         = CGRectMake(playSliderX, playSliderY, playSliderW, playSliderH);

    CGFloat endTimeX         = SCREEN_W - beginTimeW - MARGIN*0.5;
    _endTimeLabelF           = CGRectMake(endTimeX, beginTimeY, beginTimeW, beginTimeH);

    CGFloat albumWH          = SCREEN_W;
    _albumViewF              = CGRectMake(0, 0, albumWH, albumWH);

    _albumBgImageViewF       = _albumViewF;

    CGFloat toolsX           = 20;
    CGFloat toolsY           = 30;
    CGFloat toolsWH          = 40;
    _toolsBtnF               = CGRectMake(toolsX, toolsY, toolsWH, toolsWH);

        CGFloat stylusViewW = 70;
        CGFloat stylusViewH =(SCREEN_W - 2*toolsY)*2;
        CGFloat stylusViewX = SCREEN_W - stylusViewW;
           CGFloat stylusViewY        = toolsY-stylusViewH*0.5;
        _stylusBgViewF = CGRectMake(stylusViewX, stylusViewY, stylusViewW, stylusViewH);
        
    CGFloat bigGuideW        = 70;
    CGFloat bigGuideH        = SCREEN_W - 2*toolsY;
    CGFloat bigGUideX        = 0;
        CGFloat bigGuideY        = bigGuideH;
    _bigGuideImageViewF      = CGRectMake(bigGUideX, bigGuideY, bigGuideW, bigGuideH);

    CGFloat smallGuideW      = bigGuideW;
    CGFloat smallGuideH      = bigGuideH;
    _smallGuideImageViewF    = CGRectMake(0, 0, smallGuideW, smallGuideH);

    CGFloat playStylusW      = bigGuideW;
    CGFloat playStylusH      = bigGuideH;
    _playStylusImageViewF    = CGRectMake(0, 0, playStylusW, playStylusH);

    CGFloat playOrStopWH     = 90;
    CGFloat playOrStopX      = SCREEN_W*0.5 - playOrStopWH*0.5;
    CGFloat playOrStopY      = CGRectGetMaxY(_albumViewF) ;
    _playOrStopBtnF          = CGRectMake(playOrStopX, playOrStopY, playOrStopWH, playOrStopWH);

    CGFloat lastAndNextW     = 55;
    CGFloat lastAndNextH     = 70;

    CGFloat lastX            = CGRectGetMidX(_playOrStopBtnF) - playOrStopWH*0.5 - 10 - lastAndNextW;
    CGFloat lastAndNextY     = CGRectGetMidY(_playOrStopBtnF) - playOrStopWH*0.5 + 10;
    _lastMusicBtnF           = CGRectMake(lastX, lastAndNextY, lastAndNextW, lastAndNextH);

    CGFloat nextX            = CGRectGetMidX(_playOrStopBtnF) + playOrStopWH*0.5 + 10;
    _nextMusicBtnF           = CGRectMake(nextX, lastAndNextY, lastAndNextW, lastAndNextH);

    CGFloat leftPlayModeW    = 50;
    CGFloat leftPlayModeH    = 75;
        CGFloat playModeMargin =(lastX - leftPlayModeW)*0.5;
    CGFloat leftPlayModeX    = playModeMargin;
    CGFloat leftPlayModeY    = CGRectGetMidY(_lastMusicBtnF) - leftPlayModeH*0.5 ;
    _leftPlayModeBtnF        = CGRectMake(leftPlayModeX, leftPlayModeY, leftPlayModeW, leftPlayModeH);

    CGFloat rightPlayModeX   = CGRectGetMaxX(_nextMusicBtnF) + playModeMargin;
    _rightPlayModeBtnF       = CGRectMake(rightPlayModeX, leftPlayModeY, leftPlayModeW, leftPlayModeH);

    CGFloat volumeBgW        = playSliderW;
    CGFloat volumeBgH        = 55;
    CGFloat volumeBgX        = playSliderX;
    CGFloat volumebgY        = SCREEN_H - volumeBgH - MARGIN - 64;
    _volumeBgImageViewF      = CGRectMake(volumeBgX, volumebgY, volumeBgW, volumeBgH);

    CGFloat volumeSliderW    = playSliderW;
    CGFloat volumeSliderH    = volumeBgH;
    _volumeSliderF           = CGRectMake(0, 0, volumeSliderW, volumeSliderH);

    }

    return self;
}


@end
