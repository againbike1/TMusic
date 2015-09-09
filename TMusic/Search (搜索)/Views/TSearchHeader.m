//
//  TSearchHeader.m
//  TMusic
//
//  Created by Leslie on 15/9/3.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TSearchHeader.h"

@interface TSearchHeader ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textFieldMargin;
@end
@implementation TSearchHeader

#pragma mark
#pragma mark - 生命周期

+(instancetype)searchHeaderViewWithXIB
{
    return [[[NSBundle mainBundle]loadNibNamed:@"SearchHeader" owner:nil options:nil]firstObject];
}

-(void)awakeFromNib
{
    self.searchTextField.delegate = self;
}
#pragma mark
#pragma mark - 用户交互
/**
 *  监听键盘的return 给控制器发通知
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [TNotificationCenter postNotificationName:TNSearchContent object:self.searchTextField.text];
    
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   
    self.textFieldMargin.constant = 8+self.cancelButton.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}


- (IBAction)cancelButtonClick:(UIButton *)sender {
    self.textFieldMargin.constant = 8;
    [self endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
#pragma mark
