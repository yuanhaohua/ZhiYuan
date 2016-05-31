//
//  STPhotoKitController.h
//  Volunteer
//
//  Created by l k j y on 16/5/26.
//  Copyright © 2016年 康康. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STPhotoKitController;

@protocol STPhotoKitDelegate <NSObject>
- (void)photoKitController:(STPhotoKitController *)photoKitController
               resultImage:(UIImage *)resultImage;

@end

@interface STPhotoKitController : UIViewController

/** 1.原始图片, 必须设置*/
@property (nonatomic, strong) UIImage *imageOriginal;
/** 2.图片的尺寸,剪切框，最好是需求图片的2x, 默认是CGSizeMake(ScreenWidth, ScreenWidth); */
@property (nonatomic, assign) CGSize sizeClip;

@property (nullable, nonatomic, weak)id <STPhotoKitDelegate>delegate ;
@end
