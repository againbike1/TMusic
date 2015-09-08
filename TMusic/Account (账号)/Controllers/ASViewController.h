//
//  ASViewController.h
//  ASTextViewDemo
//
//  Created by Adil Soomro on 4/14/14.
//  Copyright (c) 2014 Adil Soomro. All rights reserved.
//

#import <UIKit/UIKit.h>
#define APP_KEY @"1792587465"

#define APP_SECRET @"e10353c68ee292c5e12ed8e5a51267fa"

//授权回调页
#define REDIRECT_URI @"http://www.jiakeqi.cn/"
@interface ASViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) IBOutlet UITableViewCell *email;
//cells
@property (strong, nonatomic) IBOutlet UITableViewCell *usernameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *passwordCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *doneCell;
//fields
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;

- (IBAction)changeFieldBackground:(id)sender;
- (IBAction)letMeIn:(id)sender;
+(ASViewController *)shareLoginVc;
@property (nonatomic,assign) BOOL isLogin;
@end
