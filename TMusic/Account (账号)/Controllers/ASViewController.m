//
//  ASViewController.m
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import "ASViewController.h"
#import "ASTextField.h"
#import <BmobSDK/Bmob.h>
#import "UIWindow+YzdHUD.h"
#import <BmobSDK/Bmob.h>
#import "TAccountViewController.h"
#import "TNavMianViewController.h"
@interface ASViewController ()<UIWebViewDelegate>
@property (nonatomic,retain) NSMutableArray *cellArray;
@end

@implementation ASViewController

static ASViewController *vc = nil;

+(ASViewController *)shareLoginVc
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        vc = [[ASViewController alloc]init];
    });
    return vc;
}


- (id)init
{
    self = [super initWithNibName:@"ASViewController" bundle:nil];
    if (self) {
        // Something.
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //bake a cellArray to contain all cells
    self.cellArray = [NSMutableArray arrayWithObjects:_email, _usernameCell, _passwordCell, _doneCell, nil];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    //setup text field with respective icons
    [_usernameField setupTextFieldWithIconName:@"user_name_icon"];
    [_passwordField setupTextFieldWithIconName:@"password_icon"];
      [_emailTextField setupTextFieldWithIconName:@"user_name_icon"];
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview deleagate datasource stuff
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return cell's height for particular row
    return ((UITableViewCell*)[self.cellArray objectAtIndex:indexPath.row]).frame.size.height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return number of cells for the table
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    //return cell for particular row
    cell = [self.cellArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //set clear color to cell.
    [cell setBackgroundColor:[UIColor clearColor]];
}

- (IBAction)changeFieldBackground:(UISegmentedControl *)segment {
    if ([segment selectedSegmentIndex] == 0) {
        //setup text field with default respective icons
    
        [_usernameField setupTextFieldWithIconName:@"user_name_icon"];
        [_passwordField setupTextFieldWithIconName:@"password_icon"];
         [_emailTextField setupTextFieldWithIconName:@"user_name_icon"];
    }else{
        [_usernameField setupTextFieldWithType:ASTextFieldTypeRound withIconName:@"user_name_icon"];
        [_passwordField setupTextFieldWithType:ASTextFieldTypeRound withIconName:@"password_icon"];
               [_emailTextField setupTextFieldWithType:ASTextFieldTypeRound withIconName:@"user_name_icon"];
    }
}

- (IBAction)letMeIn:(id)sender {
    [self resignAllResponders];
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    NSString *email = self.emailTextField.text;
    if (self.segment.selectedSegmentIndex) {
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUserName:username];
        [bUser setPassword:password];
        [bUser setEmail:email];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                [self.view.window showHUDWithText:@"注册成功" Type:ShowPhotoYes Enabled:YES];
                NSLog(@"注册成功");
            } else {
                   [self.view.window showHUDWithText:@"注册失败" Type:ShowPhotoNo Enabled:YES];
                NSLog(@"注册失败%@",error);
            }
        }];
    }
    else
    {
        [BmobUser loginWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
            if (error) {
                NSLog(@"%@",error);
              [self.view.window showHUDWithText:@"登录失败" Type:ShowPhotoNo Enabled:YES];
            }
            else{
                  [self.view.window showHUDWithText:@"登录成功" Type:ShowPhotoYes Enabled:YES];
                self.isLogin = YES;
                NSUserDefaults *user =   [NSUserDefaults standardUserDefaults];
                [user setObject:username forKey:@"username"];
                [user setObject:password forKey:@"password"];
                [user synchronize];

                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        
    }
}
- (void)resignAllResponders{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
}

@end
