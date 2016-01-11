//
//  TCollectViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/8.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TCollectViewController.h"
#import "TNavMianViewController.h"

@interface TCollectViewController ()
@property (nonatomic,strong)NSMutableArray *colllectArray;
@property (nonatomic, strong) NSMutableArray *downLoadArray;

@end

@implementation TCollectViewController

-(NSMutableArray *)colllectArray
{
    if (!_colllectArray) {
        _colllectArray = [NSMutableArray array];
    }
    return  _colllectArray;
}

-(NSMutableArray *)downLoadArray
{
    if (!_downLoadArray) {
        _downLoadArray = [NSMutableArray array];
    }
    return  _downLoadArray;
}

-(NSMutableArray *)downLoadModels
{
    if (!_downLoadModels) {
        _downLoadModels = [NSMutableArray array];
    }
    return  _downLoadModels;
}

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    self.title = @"我喜欢的音乐";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
        self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   }
#pragma mark
#pragma mark - 2.View代理、数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.colllectArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSString *collectCell = [NSString stringWithFormat:@"%lu",(long)indexPath.row];
    UITableViewCell *cell = [ tableView dequeueReusableCellWithIdentifier:collectCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:collectCell];
        UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%zd",indexPath.row+1];
        label.textColor =[UIColor grayColor];
        label.font = SYS_FONT(17);
        label.frame = CGRectMake(0, 0, 50, 50);
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }

    
    
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = SYS_FONT(13);
    return cell; 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
    
}

#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互




#pragma mark
#pragma mark - 4.数据处理/Http




@end


