//
//  TPlayViewController.m
//  TMusic
//
//  Created by Leslie on 15/8/29.
//  Copyright © 2015年 Leslie. All rights reserved.
//

#import "TSearchViewController.h"
#import "TSearchHeader.h"
#import "TNavMianViewController.h"
#import "TSearchResultViewController.h"
#import "SKSplashIcon.h"
@interface TSearchViewController () <SKSplashDelegate>
@property (nonatomic, strong) NSMutableArray *singerStyles;

@property (strong, nonatomic) SKSplashView *splashView;

//Demo of how to add other UI elements on top of splash view
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation TSearchViewController


#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
   [super viewDidLoad];
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    
     [self  snapchatSplash];
    
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_cm_bg"]];
    [TNotificationCenter addObserver:self selector:@selector(receivePushSearchResultvc:) name:TNSearchContent object:nil];
    
    NSString *path =[[NSBundle mainBundle]pathForResource:@"singerStyle.plist" ofType:nil];
    self.singerStyles = [NSMutableArray arrayWithContentsOfFile:path];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark
#pragma mark - 2.View代理、数据源方法

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
          return 100;
    }
        return 15;
  
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        TSearchHeader *header = [TSearchHeader searchHeaderViewWithXIB];
        header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ablum_crosstexture_bg"]];
        return header;
    }
    return nil;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互

-(UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    NSArray *tempArray = self.singerStyles[indexPath.section];
    cell.textLabel.text = tempArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 暂时未找到好用的歌手类别查询接口
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}


#pragma mark
#pragma mark - 4.数据处理/Http




- (void)receivePushSearchResultvc :(NSNotification *)noti
{
    [self searchVcPresent:noti.object type:@"1"];
}

- (void)searchVcPresent :(NSString *)result type:(NSString *)type
{
    TSearchResultViewController *resultVc = [[TSearchResultViewController alloc]init];
    resultVc.navigationItem.title = [NSString stringWithFormat:@"搜索结果 \"%@\" ",result];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:resultVc];
    resultVc.result = result;
    resultVc.type = type;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 开场
#pragma mark - Animation Examples

- (void) fadeExampleSplash
{
    SKSplashIcon *splashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"white dot.png"] animationType:SKIconAnimationTypeBlink];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:splashIcon backgroundColor:[UIColor blackColor] animationType:SKSplashAnimationTypeFade];
    _splashView.animationDuration = 5;
    [self.view addSubview:_splashView];
    [_splashView startAnimation];
}

#pragma mark - Twitter Example

- (void) twitterSplash
{
    //Setting the background
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.image = [UIImage imageNamed:@"twitter background.png"];
    [self.view addSubview:imageView];
    //Twitter style splash
    SKSplashIcon *twitterSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"twitterIcon.png"] animationType:SKIconAnimationTypeBounce];
    UIColor *twitterColor = [UIColor colorWithRed:0.25098 green:0.6 blue:1.0 alpha:1.0];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:twitterSplashIcon backgroundColor:twitterColor animationType:SKSplashAnimationTypeNone];
    _splashView.delegate = self; //Optional -> if you want to receive updates on animation beginning/end
    _splashView.animationDuration = 2; //Optional -> set animation duration. Default: 1s
    [self.view addSubview:_splashView];
    [_splashView startAnimation];
}

- (void) snapchatSplash
{
    //Snapchat style splash
    SKSplashIcon *snapchatSplashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"snapchat icon.png"] animationType:SKIconAnimationTypeNone];
    UIColor *snapchatColor = [UIColor colorWithRed:255 green:252 blue:0 alpha:1];
    _splashView = [[SKSplashView alloc] initWithSplashIcon:snapchatSplashIcon backgroundColor:snapchatColor animationType:SKSplashAnimationTypeFade];
   
}
#pragma mark - Delegate methods

- (void) splashView:(SKSplashView *)splashView didBeginAnimatingWithDuration:(float)duration
{
    NSLog(@"Started animating from delegate");
    //To start activity animation when splash animation starts
    [_indicatorView startAnimating];
}

- (void) splashViewDidEndAnimating:(SKSplashView *)splashView
{
    NSLog(@"Stopped animating from delegate");
    //To stop activity animation when splash animation ends
    [_indicatorView stopAnimating];
    
    
}




@end
