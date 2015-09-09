//
//  TSearchResultViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/3.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TSearchResultViewController.h"
#import "TSearchAlbumModel.h"
#import "TSearchSongsModel.h"
#import "TSearchArtistsModel.h"
#import "TPlayingController.h"
#import "TSearchHeader.h"
#import "TNavMianViewController.h"
#import "DXAlertView.h"
#import "TDownLoad.h"
#import "VWWWaterView.h"
#import "TDownLoadViewController.h"
#import "UIWindow+YzdHUD.h"
@interface TSearchResultViewController ()
@property (nonatomic,strong)NSMutableArray *songsArray;
@property (nonatomic,strong) TSearchSongsModel* model;
@property (nonatomic, weak) UIView *progressView;
@end

@implementation TSearchResultViewController

#pragma mark
#pragma mark - 1.View生命周期

-(NSMutableArray *)songsArray
{
    if (_songsArray== nil) {
    _songsArray                            = [NSMutableArray array];
    }
    return _songsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        [self setUpNavgationBar];
    [self searchMusicWithContent:@"0" name:self.result type:self.type];
    [self setupDownRefresh];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


#pragma mark 自定义代理

-(CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.songsArray.count;
}

-(UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSString *searchCell = [NSString stringWithFormat:@"%lu",indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:searchCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:searchCell];
        UIButton *button = [[UIButton alloc]init];
        [button setImage:[UIImage imageNamed:@"btn_download"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_download_down"] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(downLoadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(SCREEN_W-55, 0, 50, 50);
        button.tag = indexPath.row;
        cell.tag = indexPath.row;
        [cell.contentView addSubview:button];
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
        label.textColor =[UIColor grayColor];
        label.font = SYS_FONT(17);
        label.frame = CGRectMake(0, 0, 50, 50);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    TSearchSongsModel *songsModel          = self.songsArray[indexPath.row];
    TSearchAlbumModel *albumModel = songsModel.album;
    TSearchArtistsModel *artistsModel = songsModel.artists;
    
    cell.textLabel.text = songsModel.name;
    NSString *detailString = [NSString stringWithFormat:@"%@ - %@",artistsModel.name,albumModel.name];
    cell.detailTextLabel.text = detailString;
    
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = SYS_FONT(13);
    
   

    return cell;
}

#pragma mark 下载  写入数据库
- (void)downLoadBtnClick :(UIButton *)button
{
    for(UITableViewCell *cell in self.tableView.visibleCells)
    {
        if(cell.tag == button.tag)
        {
            NSLog(@"%@",cell.textLabel.text);
            TSearchSongsModel *model = self.songsArray[button.tag];
            NSString *songID = [NSString stringWithFormat:@"%zd",model.id];
            NSString *audioPath = [DOCU_PATH stringByAppendingPathComponent:songID];
            NSString *audioName = [NSString stringWithFormat:@"%zd.mp3",model.id];
            NSString *albumPath = [DOCU_PATH stringByAppendingPathComponent:songID];
            NSString *albumName = [NSString stringWithFormat:@"%zd.jpg",model.id];
            [self downloadFileURL:model.audio savePath:audioPath fileName:audioName type:@"1"];
            [self downloadFileURL:model.album.picUrl savePath:albumPath fileName:albumName type:nil];
             self.downLoadBtn = button;
            self.model = model;
        
        }
    }
}



-(void)tableView:(nonnull UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    TSearchSongsModel *songsModel          = self.songsArray[indexPath.row];
    TPlayingController *vc                 = [TPlayingController sharePlayingVc];

    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:vc];
    vc.isSearchMusic = YES;
    if (songsModel.id == vc.songsModel.id) {
        vc.isSearchMusic = NO;
    }
    if ([vc.downloadPlayer isPlaying]) {
        [vc.downloadPlayer stop];
    }
        vc.songsModel = songsModel;
    [self presentViewController:nav animated:YES completion:nil];
   
}

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互

- (void)setUpNavgationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"下载" target:self action:@selector(go)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)go
{
    TDownLoadViewController *down = [[TDownLoadViewController alloc]init];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:down];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma  mark 下载

- (void)downloadFileURL:(NSString *)aUrl savePath:(NSString *)aSavePath fileName:(NSString *)aFileName type:(NSString *)type
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@", aSavePath, aFileName];
    if ([fileManager fileExistsAtPath:fileName]) {
        NSLog(@"已经下载");
          [self.downLoadBtn setImage:[UIImage imageNamed:@"btn_download_complete2_play"] forState:UIControlStateNormal];
        [self.tableView reloadData];
            return;
    } else{
        
        if (![fileManager fileExistsAtPath:aSavePath]) {
            [fileManager createDirectoryAtPath:aSavePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSURL *url = [[NSURL alloc] initWithString:aUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        operation.inputStream = [NSInputStream inputStreamWithURL:url];
        operation.outputStream = [NSOutputStream outputStreamToFileAtPath:fileName append:NO];
        
        if (type) {
            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
              
                NSLog(@"下载进度%02f", (float)totalBytesRead/totalBytesExpectedToRead);
            }];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"下载成功");
                    dispatch_queue_t queue = dispatch_queue_create(NULL, NULL);
                    dispatch_async(queue, ^{
                        TDownLoad *download = [[TDownLoad alloc]init];
                        download.songsID = self.model.id;
                        download.songsName = self.model.name;
                        download.songsAudio = self.model.audio;
                        download.albumPicUrl = self.model.album.picUrl;
                        download.albumID = self.model.album.id;
                        download.albumName = self.model.album.name;
                        download.artistID = self.model.artists.id;
                        download.artistName = self.model.artists.name;
                        RLMRealm *realm = [RLMRealm defaultRealm];
                        [realm beginWriteTransaction];
                        [realm addObject:download];
                        [realm commitWriteTransaction];
                             NSLog(@"下载信息写入成功");
                    });
                [self.downLoadBtn setImage:[UIImage imageNamed:@"btn_download_complete2_play"] forState:UIControlStateNormal];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                NSLog(@"下载失败");
            }];
        }
        else
        {
            [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            }];
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"专辑封面保存成功");
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        [operation start];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.songsArray.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
         NSString *temp = [NSString stringWithFormat:@"%zd",self.songsArray.count+1];
        // 加载更多的微博数据
        [self searchMusicWithContent:temp name:self.result type:@"1"];
    }
}

- (void)setupDownRefresh
{
     VWWWaterView *view = [[VWWWaterView alloc]init];
    view.hidden = YES;
    self.tableView.tableFooterView =view;
    self.tableView.tableFooterView.height = 50;
}
#pragma mark
#pragma mark - 4.数据处理/Http
- (void)searchMusicWithContent :(NSString *)offset name:(NSString *)name type:(NSString *)type
{
    if (self.result) {
        NSString *str                      = @"http://s.music.163.com/search/get/";
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        NSMutableDictionary *params        = [NSMutableDictionary dictionary];
        params[@"type"]                    = type;
        params[@"s"]                       = name;
        params[@"limit"]                   = @"30";
        params[@"offset"]                  = offset;
        [mgr GET:str parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSDictionary *ResultDict  = responseObject[@"result"];
            if (!ResultDict) {
                [self.view.window showHUDWithText:@"无对应选项" Type:ShowDismiss Enabled:YES];
                return ;
            }
        NSArray *tempSongsArray = [NSArray arrayWithObject:ResultDict[@"songs"]];
            NSArray *songArray =[tempSongsArray firstObject];
        NSMutableArray *tempArray  = [NSMutableArray array];
        for (int i = 0; i<songArray.count; i++) {
        NSDictionary *songsDict = songArray[i];
        TSearchSongsModel *songsModel =[TSearchSongsModel searchSongsWithDict:songsDict];
            
                if (songsModel.artists) {
        NSArray *tempArtistsArray  = [NSArray arrayWithObject:songsModel.artists];
        NSArray *artistsArray  = [tempArtistsArray firstObject];
        for (int j = 0; j<artistsArray.count; j++) {
        NSDictionary *dict = artistsArray[j];
        songsModel.artists = [TSearchArtistsModel searchArtistsWithDict:dict];
                    }
                }
                if (songsModel.album) {
        NSDictionary *albumDict = (NSDictionary *)songsModel.album;
        songsModel.album = [TSearchAlbumModel searchAlbumWithDict:albumDict];
                    if (songsModel.album.artist) {
        NSDictionary *arlistModel = (NSDictionary *)songsModel.album.artist;
        songsModel.album.artist  = [TSearchArtistsModel searchArtistsWithDict:arlistModel];
                        [tempArray addObject:songsModel];
                    }
                }
            }
            self.tableView.tableFooterView.hidden = YES;
            [self.songsArray addObjectsFromArray:tempArray];
            [self.tableView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@" 搜索出错 %@",error);
        }];
    }
}



@end


