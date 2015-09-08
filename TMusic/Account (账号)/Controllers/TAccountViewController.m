//
//  TAccountViewController.m
//  TMusic
//
//  Created by Leslie on 15/9/2.
//  Copyright (c) 2015年 Leslie. All rights reserved.
//

#import "TAccountViewController.h"
#import "ASViewController.h"
#import "TNavMianViewController.h"
#import "VPImageCropperViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <BmobSDK/Bmob.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UIWindow+YzdHUD.h"
#define ORIGINAL_MAX_WIDTH 640.0f
@interface TAccountViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate, VPImageCropperDelegate>

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) NSMutableArray *settings;
@property (nonatomic, weak) UILabel *name;;
@end

@implementation TAccountViewController

-(NSMutableArray *)settings
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"AccountSetting.plist" ofType:nil];
    if (!_settings) {
        _settings = [NSMutableArray arrayWithContentsOfFile:path];
    }
    return  _settings;
 
}

#pragma mark
#pragma mark - 1.View生命周期

- (void)viewDidLoad {
    [super viewDidLoad];   
    self.asviewVc = [ASViewController shareLoginVc];

 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *name = [user objectForKey:@"username"];
    self.name.text = name;
    [self.tableView reloadData];
    if (self.asviewVc.isLogin) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"返回" target:self action:@selector(back)];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"登录" target:self action:@selector(login)];
    }
}

- (void)login
{
    ASViewController *as =[ASViewController shareLoginVc];
    
    TNavMianViewController *nav = [[TNavMianViewController alloc]initWithRootViewController:as];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark
#pragma mark - 2.View代理、数据源方法

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 200;
    }
    else{
        return 10;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        UIVisualEffectView *view = [[UIVisualEffectView alloc]initWithEffect:blur];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"122"]];
        imageView.size = CGSizeMake(100,100);
        imageView.center = CGPointMake(SCREEN_W*0.5, 100);
        UILabel *name = [[UILabel alloc]init];
        name.textColor = [UIColor whiteColor];
        name.font = SYS_FONT(16);
        CGFloat w = 40;
        name.frame = CGRectMake(SCREEN_W*0.5-w*0.5, CGRectGetMaxY(imageView.frame)+5, imageView.width, 30);
        self.name = name;
        [view addSubview:name];
        
        [view addSubview:imageView];
        self.portraitImageView = imageView;
        return view;
    }
    else
    {
        UIView *view1 = [[UIView alloc]init];
        view1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"controlbar_playing_bg"]];
        return  view1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *accountCell = @"accountCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountCell];
    }
    NSArray *dict = self.settings[indexPath.section];
    NSDictionary *temp =  dict[indexPath.row];
    cell.textLabel.text = temp[@"title"];
    cell.textLabel.font = SYS_FONT(16);
    cell.imageView.image = [UIImage imageNamed:temp[@"icon"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self editPortrait];
    }
    if (indexPath.section == 2 && indexPath.row == 2) {
        NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
        NSString *name = [user objectForKey:@"username"];
        NSString *pass = [user objectForKey:@"password"];
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUserName:name];
        [bUser setPassword:pass];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                NSLog(@"Sign up successfully");
                [self.view.window showHUDWithText:@"成功推出" Type:ShowPhotoYes Enabled:YES];
                [self.tableView reloadData];
                self.asviewVc.view.alpha = 1;
                        NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
                [user removeObjectForKey:@"username"];
                   [user removeObjectForKey:@"password"];
                [user synchronize];
            } else {
                NSLog(@"%@",error);
            }
        }];
    }
}

#pragma mark 自定义代理

#pragma mark 自定义通知

#pragma mark
#pragma mark - 3.用户交互


- (void)editPortrait {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册中选取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage {
    self.portraitImageView.image = editedImage;
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
        // TO DO
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController {
    [cropperViewController dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        portraitImg = [self imageByScalingToMaxSize:portraitImg];
        // 裁剪
        VPImageCropperViewController *imgEditorVC = [[VPImageCropperViewController alloc] initWithImage:portraitImg cropFrame:CGRectMake(0, 100.0f, self.view.frame.size.width, self.view.frame.size.width) limitScaleRatio:3.0];
        imgEditorVC.delegate = self;
        [self presentViewController:imgEditorVC animated:YES completion:^{
            // TO DO
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}

#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}

#pragma mark image scale utility
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark portraitImageView getter




#pragma mark
#pragma mark - 4.数据处理/Http




@end


