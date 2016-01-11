//
//  TArtistViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/9.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TArtistViewController.h"
#import "TSearchResultViewController.h"
#import "TNavMianViewController.h"

@interface TArtistViewController ()

@end

@implementation TArtistViewController

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [ self setUpNavgationBar];
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    self.tableView.tableFooterView = [[UIView alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)setUpNavgationBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark - 2.View代理、数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.artistArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *cellID = [NSString stringWithFormat:@"%lu",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
        label.textColor =[UIColor grayColor];
        label.font = SYS_FONT(17);
        label.frame = CGRectMake(0, 0, 50, 50);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    cell.textLabel.text = self.artistArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.artistArray[indexPath.row];
    
    TSearchResultViewController *search = [[TSearchResultViewController alloc]init];
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:search];
    search.result = name;
    search.type = @"1";
    search.isArtistSearch = YES;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互




#pragma mark
#pragma mark - 4.数据处理/Http




@end


