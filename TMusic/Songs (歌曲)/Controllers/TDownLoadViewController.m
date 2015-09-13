//
//  TDownLoadViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/7.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TDownLoadViewController.h"
#import "TSearchSongsModel.h"
#import "TNavMianViewController.h"
#import "TPlayingController.h"
#import "TDownLoad.h"


@interface TDownLoadViewController ()
@property (nonatomic, strong) TSearchSongsModel *model;

@end

@implementation TDownLoadViewController

-(NSMutableArray *)songsArray
{
    if (!_songsArray) {
        _songsArray = [NSMutableArray array];
    }
    return _songsArray;
}
#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavgationBar];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RLMResults *down = [TDownLoad allObjects];
    NSArray *temp1 = [NSArray arrayWithObject:down];
    self.songsArray = [temp1 firstObject];
    [self.tableView reloadData];
    NSLog(@"%@",DOCU_PATH);
}

- (void)setUpNavgationBar
{
      self.title = @"下载的音乐";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"btn_bluecd" target:self action:@selector(go)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)go
{
    TPlayingController *play = [TPlayingController sharePlayingVc];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:play];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark
#pragma mark - 2.View代理、数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *downCell = [NSString stringWithFormat:@"%zd%zd",indexPath.section,indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:downCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:downCell];
        UIButton *button = [[UIButton alloc]init];
        [button  setImage:[UIImage imageNamed:@"btn_download_complete2_play"] forState:UIControlStateNormal];
        button.frame = CGRectMake(SCREEN_W-55, 0, 50, 50);
        [cell.contentView addSubview:button];
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
        label.textColor =[UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = SYS_FONT(17);
        label.frame = CGRectMake(0, 0, 50, 50);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    TDownLoad *downModel = self.songsArray[indexPath.row];
    cell.textLabel.text = downModel.songsName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@",downModel.artistName,downModel.albumName];

    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = SYS_FONT(13);
    
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TPlayingController *playing = [TPlayingController sharePlayingVc];
    TDownLoad *down = self.songsArray[indexPath.row];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:playing];
    playing.isDownLoadMusic = YES;
    NSLog(@"%zd",playing.downLoadModel.songsID);
    if (playing.downLoadModel.songsID == down.songsID) {
        playing.isDownLoadMusic = NO;
    }
    playing.downLoadModel = down;
    [self presentViewController:nav animated:YES completion:nil];
    
}

#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互




#pragma mark
#pragma mark - 4.数据处理/Http




@end


