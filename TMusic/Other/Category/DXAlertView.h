//
//  ILSMLAlertView.h
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DXAlertView;
@protocol DXDelegate <NSObject>

- (void)dxWithTextField :(NSString *)text;

@end
@interface DXAlertView : UIView

- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle;

- (void)show;
@property (nonatomic, strong) UITextField *alertContenTextField;
//@property (nonatomic, copy) dispatch_block_t leftBlock;
@property (nonatomic, copy) dispatch_block_t rightBlock;
@property (nonatomic, copy) dispatch_block_t dismissBlock;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,weak)id<DXDelegate>delegate;
@property (nonatomic, assign)    BOOL leftLeave;
- (void)dismissAlert;
@end

@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end