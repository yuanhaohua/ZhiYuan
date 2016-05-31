//
//  UIImage+ST.h
//  Volunteer
//
//  Created by l k j y on 16/5/26.
//  Copyright © 2016年 康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ST)
//圆角图片
+ (UIImage *)imageWithClipImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)color;

/**
 *  指定区域图片的截图

 */
+ (UIImage *)imageWithSourceImage:(UIImage *)sourceImage
                         clipRect:(CGRect)clipRect;

/**
 *  截取指定位置的图片

 */
- (UIImage *)croppedImage:(CGRect)bounds;
@end
