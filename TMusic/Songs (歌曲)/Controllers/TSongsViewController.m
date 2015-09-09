//
//  TSongsViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/2.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TSongsViewController.h"
#import "TSongsListHeader.h"
#import "TPlayingController.h"
#import "DXAlertView.h"
#import "TDownLoadViewController.h"
#import "TNavMianViewController.h"
#import "TDownLoad.h"
#import "TCollectViewController.h"
#define SettingPath [[NSBundle mainBundle] pathForResource:@"SongsSetting" ofType:@"plist"]
//获取应用程序沙盒的Documents目录
#define SongsListDataPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) firstObject]stringByAppendingPathComponent:@"songslist.plist"]

@interface List :RLMObject

@property NSString *listName;
@end

@implementation List


@end

@interface TSongsViewController ()<DXDelegate>

@property (nonatomic, strong) NSMutableArray  *songsListArray;
@property (nonatomic, strong) NSMutableArray *myLikeArray;
@property (nonatomic, weak) UIView *moreView;
@property (nonatomic, assign) BOOL  isMoreBtnClick;
@property (nonatomic, copy) NSString *inputText;
@property (nonatomic, copy) NSString *collectCount;
@property (nonatomic, copy) NSString *downloadCOunt;

@end

@implementation TSongsViewController

-(NSMutableArray *)songsListArray
{
    if (_songsListArray == nil) {
        _songsListArray = [NSMutableArray array];
    }
    return _songsListArray;
}

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tableView.tableHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"search_cm_bg"]];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self setUpNavgationBar];
  self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.tableFooterView = [[UIView alloc]init];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    RLMResults *list = [List allObjects];
    NSArray *temp = [NSArray arrayWithObject:list];
    self.songsListArray = [temp firstObject];
    RLMResults *down = [TDownLoad allObjects];
    NSArray *temp1 = [NSArray arrayWithObject:down];
    NSArray *temp2 = [temp1 firstObject];
    self.downloadCOunt = [NSString stringWithFormat:@"%zd",temp2.count];
    [self.tableView reloadData];
    RLMResults *co = [Collect allObjects];
    NSArray *temp3 = [NSArray arrayWithObject:co];
    NSArray *temp4 = [temp3 firstObject];
    self.collectCount = [NSString stringWithFormat:@"%zd",temp4.count];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark
#pragma mark - 2.View代理、数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
         return 3;
    }
    else if(section == 1) {
        return 1;
    }
    else{
        return self.songsListArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0 || section==2) {
         return 0;
    }
    return 30;
   
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    TSongsListHeader *headerView = [[TSongsListHeader alloc]init];
    headerView.label.text = [NSString stringWithFormat:@"  我收藏的歌单(%lu)",self.songsListArray.count];
    headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ablum_crosstexture_bg"]];
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *songsCell = @"songsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:songsCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:songsCell];
        if (indexPath.section == 0 && indexPath.row == 0) {
            UILabel *label = [[UILabel alloc]init];
         
            label.text = self.downloadCOunt;
            label.textColor = [UIColor grayColor];
            label.font = SYS_FONT(13);
            label.frame = CGRectMake(SCREEN_W-40, 0, 40, 50);
            [cell.contentView addSubview:label];
        }
    }

    if (indexPath.section == 0) {
        NSArray *setting  = [NSArray objectArrayWithFile:SettingPath];
        NSDictionary *dict = setting[indexPath.row];
        cell.textLabel.text = dict[@"title"];
        cell.imageView.image = [UIImage imageNamed:dict[@"icon"]];
    }
    else if (indexPath.section==1 && indexPath.row==0) {
        cell.textLabel.text = @"我喜欢的音乐";
        cell.imageView.image = [UIImage imageNamed:@"blank_playlist"];
        UILabel *label = [[UILabel alloc]init];
      
        label.text = self.collectCount;
        label.textColor = [UIColor grayColor];
        label.font = SYS_FONT(13);
        label.frame = CGRectMake(SCREEN_W-40, 0, 40, 50);
        [cell.contentView addSubview:label];
    }
    else
    {
        List *list = self.songsListArray[indexPath.row];
         cell.textLabel.text = list.listName;
        cell.imageView.image = [UIImage imageNamed:@"blank_playlist"];
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
   
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0 || (indexPath.section==1 && indexPath.row==0)) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [self.songsListArray removeObjectAtIndex:indexPath.row];
//    [self.tableView reloadData];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";

}
#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互

- (void)setUpNavgationBar
{
    
    self.navigationItem.leftBarButtonItem             = [UIBarButtonItem itemWithImageName:@"mask_playing_cover_up_bg_meitu_1" target:self action:@selector(moreButtonClick:)];

}



#pragma mark 插入歌单
- (void)moreButtonClick :(UIButton *)button
{

    DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"新建歌单" contentText:@"歌单标题" leftButtonTitle:@"确认" rightButtonTitle:@"取消"];
    alert.delegate = self;
    [alert show];


    
}

-(void)dxWithTextField:(NSString *)text
{
    /*
    [self.view resignFirstResponder];
    dispatch_queue_t queqe = dispatch_queue_create(NULL, NULL);
    dispatch_async(queqe, ^{
        List *list = [[List alloc]init];
        list.listName = text;
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm beginWriteTransaction];
        [realm addObject:list];
        [realm commitWriteTransaction];
        NSLog(@"歌单写入成功");
        [self performSelectorOnMainThread:@selector(update) withObject:nil waitUntilDone:YES];
    });
    [self.songsListArray addObject:text];
     */
}


- (void)update
{
            [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        TDownLoadViewController *downVc = [[TDownLoadViewController alloc]init];
        TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:downVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    if (indexPath.section ==1 && indexPath.row == 0) {
        TCollectViewController *coVc = [[TCollectViewController alloc]init];
        TNavMianViewController *coNav = [[TNavMianViewController alloc]initWithRootViewController:coVc];
        [self presentViewController:coNav animated:YES completion:nil];
    }
}


#pragma mark
#pragma mark - 4.数据处理/Http


@end


