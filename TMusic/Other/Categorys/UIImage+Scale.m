//
//  UIImage+Scale.m
//  云图在线
//
//  Created by Jacky on 15/10/22.
//  Copyright (c) 2015年 Hydaya. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)


+ (NSData *)scaleImageToData:(UIImage *)image
{
    UIImage *newImage = [UIImage scaleImageToNewImage:image toScale:UploadImageScale];
    
    return UIImageJPEGRepresentation(newImage,UploadDataScale);
}

//    图片压缩方法
+ (UIImage *)scaleImageToNewImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
    
}

+ (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
