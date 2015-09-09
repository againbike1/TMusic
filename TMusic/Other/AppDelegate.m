//
//  AppDelegate.m
//  TMusic
//
//  Created by Leslie on 15/8/28.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "AppDelegate.h"
#import "TMainViewController.h"

#import <BmobSDK/Bmob.h>
#import "TPlayingController.h"
#import "TNavMianViewController.h"


@interface AppDelegate ()
@property (nonatomic, strong) UIButton *playingBox;
@property (nonatomic, strong) TPlayingController *playingVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TMainViewController alloc]init];
       [self.window makeKeyAndVisible];
    [Bmob registerWithAppKey:@"906d3b928eb493d1581893926802baf3"];
     [self setUpPlayingBox];
    [self setStatusBarStyle:application];
    [self setNavigationBarStyle];
   
 
    return YES;
   
}

- (void)setStatusBarStyle:(UIApplication *)application
{
    application.statusBarStyle = UIStatusBarStyleLightContent;
      application.statusBarHidden = NO;
}

- (void)setNavigationBarStyle
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *attrs = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    [navBar setTitleTextAttributes:attrs];
    [navBar setTintColor:[UIColor whiteColor]];
  
}

- (void)setUpPlayingBox
{
    self.playingBox  = [[UIButton alloc]init];
    [self.playingBox setImage:[UIImage imageNamed:@"btn_bluecd"] forState:UIControlStateNormal];
    self.playingBox.frame = CGRectMake(SCREEN_W-63, 28, 48, 30);
    [self.window.rootViewController.view addSubview:self.playingBox];
    [self.playingBox addTarget:self action:@selector(playingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.playingVc = [TPlayingController sharePlayingVc];

    [TNotificationCenter addObserver:self selector:@selector(hiddenPlayingBox) name:@"hiddenPlayingBox" object:nil];
    [TNotificationCenter addObserver:self selector:@selector(displayPlayingBox) name:@"displayPlayingBox" object:nil];
    
}

- (void)displayPlayingBox
{
    self.playingBox.hidden = NO;
}

- (void)hiddenPlayingBox
{
    self.playingBox.hidden = YES;
}

- (void)playingButtonClick
{
    UIWindow *window = (UIWindow *)[[UIApplication sharedApplication].windows lastObject];
    TNavMianViewController *nav = (TNavMianViewController *)window.rootViewController;
    TNavMianViewController *playingVc = [[TNavMianViewController alloc]initWithRootViewController:self.playingVc];
    [nav presentViewController:playingVc animated:YES completion:nil];
   
    
}



@end
