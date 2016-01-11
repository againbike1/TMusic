//
//  AppDelegate.m
//  TMusic
//
//  Created by Leslie on 15/8/28.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "AppDelegate.h"
#import "TMainViewController.h"
#import "TNavMianViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) UIButton *playingBox;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[TMainViewController alloc]init];
    [self.window makeKeyAndVisible];
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

- (void)displayPlayingBox
{
    self.playingBox.hidden = NO;
}

- (void)hiddenPlayingBox
{
    self.playingBox.hidden = YES;
}



@end
