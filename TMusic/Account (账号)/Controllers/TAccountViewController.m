//
//  TAccountViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/2.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TAccountViewController.h"
#import "ASViewController.h"
#import "TNavMianViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <BmobSDK/Bmob.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIWindow+YzdHUD.h"
#import "TAccountHeader.h"
#import "UMSocial.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface TAccountViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate,UMSocialUIDelegate>
@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) NSMutableArray *settings;
@property (nonatomic, weak) UILabel *name;;
@property (nonatomic, strong) UIImageView *iconImageView;;
@end

@implementation TAccountViewController

-(NSMutableArray *)settings
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"AccountSetting.plist" ofType:nil];
    if (!_settings) {
        _settings = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return  _settings;
 
}

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];   
    self.asviewVc = [ASViewController shareLoginVc];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *name = [user objectForKey:@"username"];
    self.name.text = name;
    [self.tableView reloadData];
    if (self.asviewVc.isLogin) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"登录" target:self action:@selector(login)];
    }
}

- (void)login
{
    ASViewController *as =[ASViewController shareLoginVc];
    
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:as];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark
#pragma mark - 2.View代理、数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 150;
    }
    else{
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blur];
        self.iconImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"122"]];
        CGFloat iconWH = 100;
        self.iconImageView.frame  = CGRectMake(SCREEN_W*0.5-iconWH*0.5,75-iconWH*0.5, iconWH, iconWH);
        [view addSubview:self.iconImageView];

        return view;
    }
    else
    {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"controlbar_playing_bg"]];
        return  view1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *accountCell = @"accountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountCell];
    }
    NSArray *dict = self.settings[indexPath.section];
    NSDictionary *temp =  dict[indexPath.row];
    cell.textLabel.text = temp[@"title"];
    cell.textLabel.font = SYS_FONT(16);
    cell.imageView.image = [UIImage imageNamed:temp[@"icon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
     
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
        NSString *name = [user objectForKey:@"username"];
        NSString *pass = [user objectForKey:@"password"];
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUserName:name];
        [bUser setPassword:pass];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                NSLog(@"Sign up successfully");
                [self.view.window showHUDWithText:@"成功推出" Type:ShowPhotoYes Enabled:YES];
                [self.tableView reloadData];
                self.asviewVc.view.alpha = 1;
                        NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
                [user removeObjectForKey:@"username"];
                   [user removeObjectForKey:@"password"];
                [user synchronize];
            } else {
                NSLog(@"%@",error);
            }
        }];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"55eff73367e58eaa74002328"
                                          shareText:@"TMusic,一个开源的移植Smartisan OS音乐播放器 代码请戳:https://github.com/LeslieJia/TMusic"
                                         shareImage:[UIImage imageNamed:@"good"]
                                    shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToRenren,UMShareToQzone,UMShareToQQ,UMShareToDouban,UMShareToTwitter,UMShareToFacebook,nil]
                                           delegate:self];
    }
}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    [self.view.window showHUDWithText:@"分享成功" Type:ShowPhotoYes Enabled:YES];
}
#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互



@end


