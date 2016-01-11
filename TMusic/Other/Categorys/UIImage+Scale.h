//
//  UIImage+Scale.h
//  云图在线
//
//  Created by Jacky on 15/10/22.
//  Copyright (c) 2015年 Hydaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UploadImageScale 0.6
#define UploadDataScale 0.3
@interface UIImage (Scale)

+ (UIImage *)scaleImageToNewImage:(UIImage *)image toScale:(float)scaleSize;

+ (NSData *)scaleImageToData:(UIImage *)image;

+ (UIImage *) captureScreen;

@end
