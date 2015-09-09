//
//  TPlayingViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/1.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TPlayingController.h"
#import "TPlayingView.h"
#import "TSearchSongsModel.h"
#import "TPlayButton.h"
#import <Accounts/Accounts.h>
#import "TDownLoad.h"
#import "TDownLoadViewController.h"
#import "UIWindow+YzdHUD.h"
#import <Social/Social.h>
#import "UMSocial.h"
#import <MediaPlayer/MediaPlayer.h>
@implementation Collect

@end
@interface TPlayingController ()<STKAudioPlayerDelegate,AVAudioPlayerDelegate,UITableViewDelegate,UITableViewDataSource,UMSocialUIDelegate>
@property (nonatomic, weak) TPlayingView           *playingView;

@property (nonatomic, weak) UIButton *stopButton;
@property (nonatomic, weak) UIImageView *albumImageView;
@property (nonatomic, weak) UISlider *playSlider;
@property (nonatomic, weak) UISlider *volumeSlider;
@property (nonatomic, weak) UILabel *beginTime;
@property (nonatomic, weak) UILabel *endTime;
@property (nonatomic, weak) UIButton *toolsButton;
@property (nonatomic, assign) BOOL isToolsBtnClick;
@property (nonatomic, strong) NSTimer *albumeRotationTimer;
@property (nonatomic, strong)NSTimer *progressTimer;
@property (nonatomic, weak) UIButton *lyricsBtn;
@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIButton *timerBtn;
@property (nonatomic, weak) UIButton *addlistBtn;
@property (nonatomic, weak) UIVisualEffectView *visualView1;
@property (nonatomic, weak) UIVisualEffectView *visualView2;
@property (nonatomic, weak) UIButton *tempToolsButton;
@property (nonatomic, weak) UIView *albumView;
@property (nonatomic, assign) BOOL isLrcBtnClick;
@property (nonatomic, assign) NSInteger lrcLineNumber;
@property (nonatomic, weak)   UITableView *listTableView;
@property (nonatomic, assign) BOOL isListBtnClick;
@property (nonatomic, strong) NSMutableArray *songsListArray;
@property (nonatomic, assign) BOOL isRadomPlay;
@property (nonatomic,assign) BOOL isLast;
@property (nonatomic, assign) BOOL isResume;
@end

@implementation TPlayingController



-(NSMutableArray *)songsListArray
{
    if (!_songsListArray) {
        _songsListArray = [NSMutableArray array];
    }
    return _songsListArray;
}

static   TPlayingController *vc = nil;

+(TPlayingController *)sharePlayingVc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[TPlayingController alloc]init];
        vc.player = [[STKAudioPlayer alloc]init];
    });
    return vc;
}

#pragma mark
#pragma mark - 1.View生命周期

-(void)dealloc
{
    [self.albumeRotationTimer invalidate];
    [self.progressTimer invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self setUpPlayingView];
     [self addPlayingViewObserver];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [TNotificationCenter postNotificationName:@"hiddenPlayingBox" object:nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    if (self.isSearchMusic) {
        [self SongsWillPlaying];
        NSLog(@"接收到了在线试听");
        self.isSearchMusic = NO;
        if (self.downloadPlayer) {
            [self.downloadPlayer stop];
        }
    }
    if (self.isDownLoadMusic) {
        [self downLoadSongsWillPlaying];
        NSLog(@"收到了本地播放");
        [self.player stop];
        self.isDownLoadMusic = NO;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
      [self.listTableView removeFromSuperview];
    [self resignFirstResponder];
}
- (void)setUpPlayingView
{
      self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"btn_playing_back" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"btn_playing_list" target:self action:@selector(list)];
    TPlayingView *playingView          = [[TPlayingView alloc]init];
    playingView.userInteractionEnabled = YES;
    playingView.frame                  = self.view.bounds;
    [self.view addSubview:playingView];
    self.playingView                   = playingView;
    self.stopButton                    = self.playingView.stopButton;
    self.albumImageView                = self.playingView.albumImageView;
    self.playSlider                    = self.playingView.playSlider;
    self.volumeSlider                  = self.playingView.volumeSlider;
    self.beginTime                     = self.playingView.beginTimeLabel;
    self.endTime                       = self.playingView.endTimeLabel;
    self.toolsButton                   = self.playingView.toolsButton;
    self.albumView = self.playingView.albumView;
    self.beginTime.text                = @"00:00";
    self.endTime.text                  = @"00:00";

}

- (void)addPlayingViewObserver
{
 
    [self.stopButton addTarget:self action:@selector(stopButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.toolsButton addTarget:self action:@selector(toolsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIPanGestureRecognizer *rotation = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(rotationGes:)];
 
    [self.playingView.lastMusicButton  addTarget:self action:@selector(lastMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.playingView.nextMusicButton addTarget:self action:@selector(nextMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.playingView.leftPlayModeButton addTarget:self action:@selector(repeatsPlay) forControlEvents:UIControlEventTouchUpInside];
    [self.playingView.rightPlayModeButton addTarget:self action:@selector(randomPlay) forControlEvents:UIControlEventTouchUpInside ];
    [self.playingView.albumView addGestureRecognizer:rotation];
    self.albumImageView.userInteractionEnabled      = YES;
    self.playingView.volumeBgImageView.userInteractionEnabled   = YES;
    self.playingView.playingView.userInteractionEnabled = YES;
    self.playingView.albumBgImageView.userInteractionEnabled = YES;
    self.albumImageView.userInteractionEnabled = YES;
    self.playingView.topView.userInteractionEnabled = YES;

}

- (void)repeatsPlay
{
    if ([self.downloadPlayer isPlaying] && self.isRadomPlay) {
        [self.playingView.leftPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_cycle_on"] forState:UIControlStateNormal];
         [self.playingView.rightPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_shuffle_off"] forState:UIControlStateNormal];
                self.isRadomPlay = NO;
    }
    
    
}
- (void)randomPlay
{
    if ([self.downloadPlayer isPlaying] && !self.isRadomPlay) {
        [self.playingView.rightPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_shuffle_on"] forState:UIControlStateNormal];
          [self.playingView.leftPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_cycle_off"] forState:UIControlStateNormal];
            self.isRadomPlay = YES;
    }
}
- (void)lastMusic
{
    TDownLoad *temp = [self.songsListArray firstObject];
    [self seleteLastOrNext:temp type:-1];
}

- (void)nextMusic
{
   
    TDownLoad *temp = [self.songsListArray lastObject];
    [self seleteLastOrNext:temp type:1];
}

- (void)seleteLastOrNext :(TDownLoad *)params type:(NSInteger)type
{
    if ([self.downloadPlayer isPlaying]) {
        for (int i =0; i<self.songsListArray.count; i++) {
            TDownLoad *download = self.songsListArray[i];
            if (download.songsID == self.downLoadModel.songsID) {
          
                if (self.downLoadModel.songsID == params.songsID) {
                    break;
                }
                if (self.songsListArray[i+type]) {
                    self.downLoadModel = self.songsListArray[i+type];
                    [self downLoadSongsWillPlaying];
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i+type inSection:0];
                    [self.listTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
                    break;
                    
                }
            }
        }
    }
}

- (void)list
{
    RLMResults *down = [TDownLoad allObjects];
    NSArray *temp1 = [NSArray arrayWithObject:down];
    self.songsListArray = [temp1 firstObject];
        [self.listTableView reloadData];
    if (self.isListBtnClick) {
        
        [self.listTableView removeFromSuperview];
    }
    else{
        UITableView *listTableView = [[UITableView alloc]init];
        CGFloat w = SCREEN_W*0.5;
        CGFloat h = SCREEN_H*0.5;
        listTableView.frame  = CGRectMake(SCREEN_W-w, 64, w, h);
        listTableView.alpha = 0.6;
        listTableView.delegate = self;
        listTableView.dataSource = self;
        listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
        [window addSubview:listTableView];
        self.listTableView = listTableView;
        
    }
    self.isListBtnClick = !self.isListBtnClick;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songsListArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *listCell = @"listCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:listCell];
    }
    TDownLoad *downModel = self.songsListArray[indexPath.row];
    cell.textLabel.text = downModel.songsName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",downModel.artistName,downModel.albumName];
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = SYS_FONT(13);

    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.player.state == STKAudioPlayerStatePlaying) {
        [self.player stop];
    }
    TDownLoad *down = self.songsListArray[indexPath.row];
    if (down.songsID == self.downLoadModel.songsID) {
        self.isResume = YES;
    }
    else{
        self.isResume = NO;
    }
        self.downLoadModel = self.songsListArray[indexPath.row];
   [self downLoadSongsWillPlaying];
    self.isListBtnClick = NO;
    [UIView animateWithDuration:1.25 animations:^{
        [self.listTableView removeFromSuperview];
    }];
}

- (void)back
{
  [TNotificationCenter postNotificationName:@"displayPlayingBox" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark 自定义通知 响应方法

- (void)rotationGes :(UIPanGestureRecognizer *)gesture
{
        self.albumView.transform = CGAffineTransformRotate(self.albumView.transform, 0.05);
}

- (void)toolsButtonClick :(UIButton *)button
{
    if (self.isToolsBtnClick) {
      
        [self.visualView1 removeFromSuperview];
         [self.visualView2 removeFromSuperview];
          [button setImage:[UIImage imageNamed:@"btn_unbrella_icon0"] forState:UIControlStateNormal];
    }
    else{
         [button setImage:[UIImage imageNamed:@"btn_unbrella_icon10"] forState:UIControlStateNormal];
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        UIVisualEffectView *visualView1 = [[UIVisualEffectView alloc]initWithEffect:blur];
        visualView1.frame = CGRectMake(0, self.playingView.playingView.y-2, SCREEN_W,CGRectGetMaxY(self.playingView.albumBgImageView.frame));
             [self.view addSubview:visualView1];
          self.visualView1 = visualView1;
        
        UIVisualEffectView *visualView2 = [[UIVisualEffectView alloc]initWithEffect:blur];
        visualView2.frame = CGRectMake(0, visualView1.height-2, SCREEN_W,SCREEN_H-visualView1.height);
 
        [self.playingView.playingView insertSubview:visualView2 belowSubview:self.playingView.stopButton];
        self.visualView2 = visualView2;
        
        CGFloat toolButtonWH = 35;
        UIButton *lyricsBtn = [self toolsButtonAddChildBtnWithImageName:@"lyrics_btn-1" frame:CGRectMake(30, button.y+120, toolButtonWH, toolButtonWH)];
        [self.visualView1 addSubview:lyricsBtn];
        self.lyricsBtn = lyricsBtn;
           [lyricsBtn addTarget:self action:@selector(lyricsBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *shareBtn = [self toolsButtonAddChildBtnWithImageName:@"share_btn-1" frame:CGRectMake(CGRectGetMaxX(lyricsBtn.frame)+MARGIN, CGRectGetMinY(lyricsBtn.frame)-toolButtonWH, toolButtonWH, toolButtonWH)];
        [self.visualView1 addSubview:shareBtn];
        self.shareBtn = shareBtn;
           [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *timerBtn = [self toolsButtonAddChildBtnWithImageName:@"timer_btn-1" frame:CGRectMake(CGRectGetMaxX(shareBtn.frame)+MARGIN*0.5,CGRectGetMinY(shareBtn.frame)-toolButtonWH, toolButtonWH, toolButtonWH)];
        [self.visualView1 addSubview:timerBtn];
        self.timerBtn = timerBtn;
           [timerBtn addTarget:self action:@selector(timerBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *addlistBtn = [self toolsButtonAddChildBtnWithImageName:@"addlist_btn-1" frame:CGRectMake(CGRectGetMaxX(timerBtn.frame)+MARGIN*0.5, CGRectGetMinY(timerBtn.frame)-toolButtonWH, toolButtonWH, toolButtonWH)];
        [self.visualView1 addSubview:addlistBtn];
        self.addlistBtn = addlistBtn;
           [addlistBtn addTarget:self action:@selector(addlistBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIButton *tempToolsButton = [[UIButton alloc]initWithFrame:CGRectMake(self.toolsButton.x, self.toolsButton.y, self.toolsButton.width, self.toolsButton.height)];
        [tempToolsButton setImage:[UIImage imageNamed:@"btn_unbrella_icon10"] forState:UIControlStateNormal];
        [tempToolsButton setBackgroundImage:[UIImage imageNamed:@"btn_unbrella_down"] forState:UIControlStateNormal];
        [tempToolsButton setBackgroundImage:[UIImage imageNamed:@"btn_unbrella"] forState:UIControlStateHighlighted];
        [self.visualView1 addSubview:tempToolsButton];
        self.tempToolsButton = tempToolsButton;
        [tempToolsButton addTarget:self action:@selector(tempToolsButtonClick) forControlEvents:UIControlEventTouchUpInside];
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tempToolsButtonClick)];
        [self.visualView1 addGestureRecognizer:longPress];
        
    }
    self.isToolsBtnClick = !self.isToolsBtnClick;
   
}
- (void)shareBtnClick
{
    if ([self.downloadPlayer isPlaying]) {
        NSString *name = self.downLoadModel.songsName;
        NSString *content = [NSString stringWithFormat:@"我推荐了%@这首歌,你也来听听吧%@",name,self.downLoadModel.songsAudio];
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"55eff73367e58eaa74002328"
                                          shareText:content
                                         shareImage:[UIImage imageNamed:@"good"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToRenren,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToTwitter,UMShareToFacebook,nil]
                                           delegate:self];
    }
    else
    {
           [self.view.window showHUDWithText:@"你还没播放呢!" Type:ShowDismiss Enabled:YES];
    }
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    [self.view.window showHUDWithText:@"分享成功" Type:ShowPhotoYes Enabled:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [self.visualView1  removeFromSuperview];
        [self.visualView2  removeFromSuperview];
        self.isToolsBtnClick = YES;
    }];
}
- (void)timerBtnClick
{
    NSLog(@"2");
}

#pragma mark 收藏
- (void)addlistBtnClick
{
    if (self.downLoadModel.songsID) {
      
        dispatch_queue_t queque = dispatch_queue_create(NULL, NULL);
        dispatch_sync(queque, ^{
            Collect *collect = [[Collect alloc]init];
            collect.collectSongsID = self.downLoadModel.songsID;
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm beginWriteTransaction];
            [realm addObject:collect];
            [realm commitWriteTransaction];
            NSLog(@"歌曲收藏写入成功");
        });
        [self.visualView1.window showHUDWithText:@"收藏成功" Type:ShowPhotoYes Enabled:YES];
        [UIView animateWithDuration:0.25 animations:^{
            [self.visualView1  removeFromSuperview];
              [self.visualView2  removeFromSuperview];
            self.isToolsBtnClick = YES;
        }];
    }
}
#pragma mark 请求歌词
#warning 暂未找到好用的歌词API 因歌词涉及版权 未加入该模块
- (void)lyricsBtnClick
{
    if (self.isLrcBtnClick) {
        
    }else {
        [self.timerBtn removeFromSuperview];
        [self.addlistBtn removeFromSuperview];
        [self.shareBtn removeFromSuperview];
        [self.lyricsBtn removeFromSuperview];
    }
    self.isLrcBtnClick = !self.isLrcBtnClick;
}

- (void)tempToolsButtonClick
{
    [self.tempToolsButton removeFromSuperview];
       [self.playingView.playingView addSubview:self.toolsButton];
    [self.toolsButton setImage:[UIImage imageNamed:@"btn_unbrella_icon0"] forState:UIControlStateNormal];
    self.isToolsBtnClick = NO;
    [self.visualView1 removeFromSuperview];
    [self.visualView2 removeFromSuperview];
}

- (UIButton *)toolsButtonAddChildBtnWithImageName :(NSString *)image frame:(CGRect)frame
{
    TPlayButton *button = [[TPlayButton alloc]initWithFrame:frame];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    return button;
}

- (void)stopButtonClick
{
    if (self.player.state == STKAudioPlayerStatePlaying ||[self.downloadPlayer isPlaying]) {
          [self.stopButton setImage:[UIImage imageNamed:@"btn_playing_play"] forState:UIControlStateNormal];
 
          [self.player pause];
        [self.downloadPlayer pause];
    }
    
    else
    {
        [self.stopButton setImage:[UIImage imageNamed:@"btn_playing_pause"] forState:UIControlStateNormal];
        [self.player resume];
        [self.downloadPlayer play];
    }
}

#pragma mark
#pragma mark - 3.用户交互 歌曲将要播放 :!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/**
 *  歌曲将要播放
 */
- (void)SongsWillPlaying
{
    [self.downloadPlayer stop];
    [self.progressTimer invalidate];
    [self.albumeRotationTimer invalidate];
    [self.albumImageView sd_setImageWithURL:[NSURL URLWithString:self.songsModel.album.picUrl]];
    NSURL *url                            = [NSURL URLWithString:self.songsModel.audio];
    self.player.delegate = self;
    [self.player playURL:url];
    if (!self.player)
    {
        return;
    }
        self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@",self.songsModel.name,self.songsModel.artists.name];
    [self.downloadPlayer stop];
        [self.stopButton setImage:[UIImage imageNamed:@"btn_playing_pause"] forState:UIControlStateNormal];
    self.albumeRotationTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(albumViewRotation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.albumeRotationTimer forMode:NSRunLoopCommonModes];
    self.progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(track1) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    [self.playSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)downLoadSongsWillPlaying
{
    if (self.isResume) {
        return;
    }
       [self.player stop];
    [self.progressTimer invalidate];
    [self.albumeRotationTimer invalidate];
        self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@",self.downLoadModel.songsName,self.downLoadModel.artistName];
    
       NSString *path = [NSString stringWithFormat:@"%@/%zd/%zd",DOCU_PATH,self.downLoadModel.songsID,self.downLoadModel.songsID];
        NSString *songsPath = [NSString stringWithFormat:@"%@.mp3",path];
        NSString *albumPath = [NSString stringWithFormat:@"%@.jpg",path];
    self.albumImageView.image = [UIImage imageWithContentsOfFile:albumPath];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    NSURL *audioUrl = [NSURL fileURLWithPath:songsPath];
 
    self.downloadPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:audioUrl error:nil];
    self.downloadPlayer.delegate = self;
    if (self.downloadPlayer == NULL)
    {
        NSLog(@"fail to play audio :(");
        return;
    }

    [self.downloadPlayer setNumberOfLoops:0];
    [self.downloadPlayer prepareToPlay];
    [self.downloadPlayer play];
    [self.stopButton setImage:[UIImage imageNamed:@"btn_playing_pause"] forState:UIControlStateNormal];
    NSLog(@"开始播放");
       [self.playingView.leftPlayModeButton setImage:[UIImage imageNamed:@"btn_playing_cycle_on"] forState:UIControlStateNormal];
    self.albumeRotationTimer = [NSTimer timerWithTimeInterval:0.01 target:self selector:@selector(albumViewRotation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.albumeRotationTimer forMode:NSRunLoopCommonModes];
    self.progressTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(track2) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.progressTimer forMode:NSRunLoopCommonModes];
    [self.playSlider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventTouchUpInside];
    [self.playingView.volumeSlider addTarget:self action:@selector(changeVolume:) forControlEvents:UIControlEventTouchUpInside];;
 
}

#pragma mark
#pragma mark - 4.数据处理/Http


#pragma mark
#pragma mark __代理

- (void)changeVolume :(UISlider *)slider
{
    if ([self.downloadPlayer isPlaying]) {
        [self.downloadPlayer setVolume:slider.value*7];
    }
    else {
        self.player.volume =  slider.value*100;
    }
}

-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId
{
 
}
/**
 *  专辑封面旋转
 */
- (void)albumViewRotation
{
    if (self.player.state == STKAudioPlayerStatePlaying || [self.downloadPlayer isPlaying]) {
        self.albumView.transform = CGAffineTransformRotate(self.albumView.transform, 0.005);
    }
}
/**
 *  更新时间
 */
- (void)track1
{
    if (self.playSlider) {
        self.playSlider.maximumValue  = self.player.duration;
        self.playSlider.value = self.player.progress;
        
        NSInteger proMin = (NSInteger)self.player.progress/60;
        NSInteger proSec = (NSInteger)self.player.progress%60;
        NSInteger durMin = (NSInteger)self.player.duration/60;
        NSInteger durSec = (NSInteger)self.player.duration%60;
        
        self.beginTime.text = [NSString stringWithFormat:@"%02ld:%02ld",proMin,proSec];
        self.endTime.text = [NSString stringWithFormat:@"%02ld:%02ld",durMin,durSec];
        self.player.volume = self.volumeSlider.value;
    }

}

- (void)track2
{
    if (self.playSlider) {
        self.playSlider.maximumValue  = self.downloadPlayer.duration;
        self.playSlider.value = self.downloadPlayer.currentTime;
        
        NSInteger proMin = (NSInteger)self.downloadPlayer.currentTime/60;
        NSInteger proSec = (NSInteger)self.downloadPlayer.currentTime%60;
        NSInteger durMin = (NSInteger)self.downloadPlayer.duration/60;
        NSInteger durSec = (NSInteger)self.downloadPlayer.duration%60;
        
        self.beginTime.text = [NSString stringWithFormat:@"%02ld:%02ld",proMin,proSec];
        self.endTime.text = [NSString stringWithFormat:@"%02ld:%02ld",durMin,durSec];
        self.player.volume = self.volumeSlider.value;
    }
   
}

/**
 *  改变播放进度
 */
- (void)changeProgress :(UISlider *)slider
{
    if (!self.player && !self.downloadPlayer) {
        return;
    }
    else if (self.player.state == STKAudioPlayerStatePlaying)
    {
         [self.player seekToTime:self.playSlider.value];
    }
    else if ([self.downloadPlayer isPlaying])
    {
        [self.downloadPlayer setCurrentTime:self.playSlider.value];
    }
    else {
        return;
    }
    
}
#pragma mark 本地播放完毕
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer*)player successfully:(BOOL)flag{
    //播放结束时执行的动作
    NSLog(@"播放完毕");
    [self playMode];
}

- (void)playMode
{
    if (self.isRadomPlay) {
        NSInteger count =  random()%self.songsListArray.count;
        self.downLoadModel = self.songsListArray[count];
        [self downLoadSongsWillPlaying];
    }
    else    {
        for (int i=0; i<self.songsListArray.count+1; i++) {
            TDownLoad *temp = self.songsListArray[i];
            if (self.downLoadModel.songsID == temp.songsID) {
                
                TDownLoad *temp1= [self.songsListArray lastObject];
                
                if ([self.songsListArray[i] songsID] == temp1.songsID) {
                    
                    if (self.isLast) {
                        TDownLoad *temp2= [self.songsListArray firstObject];
                        self.downLoadModel = temp2;
                        [self downLoadSongsWillPlaying];
                        self.isLast = NO;
                        break;
                        
                    }
                    else{
                        self.downLoadModel = temp1;
                        [self downLoadSongsWillPlaying];
                        self.isLast = YES;
                        break;
                    }
                }
                 if ([self.songsListArray[i+1] songsID])
                {
                    self.downLoadModel =self.songsListArray[i+1 ];
                    [self downLoadSongsWillPlaying];
                    break;
                }
            
            }
        }
    }
}

-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId
{
    NSLog(@"完成加载");
 
}

-(void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration
{

    NSLog(@"结束播放");
}

-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState
{
    
}
-(void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode
{
    
}


@end
