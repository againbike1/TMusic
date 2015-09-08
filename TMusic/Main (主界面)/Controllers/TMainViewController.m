//
//  TMainViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/2.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TMainViewController.h"
#import "TSearchViewController.h"
#import "TNavMianViewController.h"
#import "TSongsViewController.h"
#import "TAccountViewController.h"
#import "TTabbar.h"
#import "TPlayingController.h"
@interface TMainViewController ()

@end

@implementation TMainViewController

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {

    [super viewDidLoad];
    
    TTabbar *tabbar = [[TTabbar alloc]init];
    [self setValue:tabbar forKeyPath:@"tabBar"];
    
    TSearchViewController *search = [[TSearchViewController alloc]init];
    [self addChildViewController:search title:@"搜索" imageName:@"tabbar_cloudmusic"];
    
    TSongsViewController *songs = [[TSongsViewController alloc]init];
    [self addChildViewController:songs title:@"歌单" imageName:@"tabbar_song"];
    
//    TPlayingController *playing = [[TPlayingController alloc]init];
//    [self addChildViewController:playing title:@"歌曲" imageName:@"blank_song"];
//
 
    TAccountViewController *account = [[TAccountViewController alloc]init];
    [self addChildViewController:account title:@"账号" imageName:@"tabbar_artist"];
 
  
}
 int i = 0;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark
#pragma mark - 2.View代理、数据源方法


#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互


-(void)addChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName
{
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    NSString *seletedImageName = [NSString stringWithFormat:@"%@_down",imageName];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:seletedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childVc.title = title;
    NSMutableDictionary *seletedDict = [NSMutableDictionary dictionary];
    seletedDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
      dict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childVc.tabBarItem setTitleTextAttributes:dict forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:seletedDict forState:UIControlStateSelected];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVc];
    [self addChildViewController:nav];
}




#pragma mark
#pragma mark - 4.数据处理/Http




@end


