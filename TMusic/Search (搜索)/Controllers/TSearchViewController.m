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
#import "TSearchViewController.h"
#import "TSearchHeader.h"
#import "TNavMianViewController.h"
#import "TSearchResultViewController.h"
#import "TArtistViewController.h"
@interface TSearchViewController ()
@property (nonatomic, strong) NSMutableArray *artistStyles;
@property (nonatomic, strong) NSMutableArray *chinaMan;
@property (nonatomic, strong) NSMutableArray *chinaWoman;
@property (nonatomic, strong) NSMutableArray *chinaGroup;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@end

@implementation TSearchViewController

-(NSMutableArray *)chinaMan
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ChinaMan.plist" ofType:nil];
    if (!_chinaMan) {
        _chinaMan = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _chinaMan;
}

-(NSMutableArray *)chinaWoman
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ChinaWoman.plist" ofType:nil];
    if (!_chinaWoman) {
        _chinaWoman = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _chinaWoman;
}

-(NSMutableArray *)chinaGroup
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"ChinaGroup.plist" ofType:nil];
    if (!_chinaGroup) {
        _chinaGroup = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _chinaGroup;
}

-(NSMutableArray *)artistStyles
{
    NSString *path =[[NSBundle mainBundle]pathForResource:@"singerStyle.plist" ofType:nil];
    if (!_artistStyles) {
       _artistStyles = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return _artistStyles;
}
#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
   [super viewDidLoad];
//    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_cm_bg"]];
    [TNotificationCenter addObserver:self selector:@selector(receivePushSearchResultvc:) name:TNSearchContent object:nil];
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
    NSArray *tempArray = self.artistStyles[indexPath.section];
    cell.textLabel.text = tempArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - 暂时未找到好用的歌手类别查询接口
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TArtistViewController *artistVc = [[TArtistViewController alloc]init];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:artistVc];
    NSArray *tempArray = [NSArray array];
    nav.title = @"暂不支持此类型搜索";
    
    if (indexPath.section == 0 ) {
        tempArray = self.artistStyles[0];
        if (indexPath.row == 0) {
            artistVc.title =tempArray[0];
            artistVc.artistArray = self.chinaMan;
        }
        else if (indexPath.row == 1) {
              artistVc.title =tempArray[1];
            artistVc.artistArray = self.chinaWoman;
        }
        else {
              artistVc.title =tempArray[2];
            artistVc.artistArray = self.chinaGroup;
        }
    }
    
    [self presentViewController:nav animated:YES completion:nil];
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





@end
