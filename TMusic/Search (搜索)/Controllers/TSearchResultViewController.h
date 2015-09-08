//
//  TSearchResultViewController.h
//  TMusic
//
//  Created by Leslie on 15/9/3.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSearchResultViewController : UITableViewController

@property (nonatomic, copy) NSString *result;
@property (nonatomic, copy) NSString *type;
- (void)searchMusicWithContent :(NSString *)offset name:(NSString *)name type:(NSString *)type;
@property (nonatomic, strong) UIButton* downLoadBtn;
@end
