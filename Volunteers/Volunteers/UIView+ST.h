//
//  UIView+ST.h
//  Volunteer
//
//  Created by l k j y on 16/5/26.
//  Copyright © 2016年 康康. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (ST)
/**
 *  1.间隔X值
 */
@property (nonatomic, assign) CGFloat x;

/**
 *  2.间隔Y值
 */
@property (nonatomic, assign) CGFloat y;

/**
 *  3.宽度
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  4.高度
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  5.中心点X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  6.中心点Y值
 */
@property (nonatomic, assign) CGFloat centerY;

/**
 *  7.尺寸大小
 */
@property (nonatomic, assign) CGSize size;

/**
 *  8.起始点
 */
@property (nonatomic, assign) CGPoint origin;

/**
 *  9.上 < Shortcut for frame.origin.y
 */
@property (nonatomic) CGFloat top;

/**
 *  10.下 < Shortcut for frame.origin.y + frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 *  11.左 < Shortcut for frame.origin.x.
 */
@property (nonatomic) CGFloat left;

/**
 *  12.右 < Shortcut for frame.origin.x + frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 *  13.设置镂空中间的视图
 *
 *  @param centerFrame 中间镂空的框架
 */
- (void)setHollowWithCenterFrame:(CGRect)centerFrame;
/**
 *  14.获取屏幕图片
 *  @return <#return value description#>
 */
- (UIImage *)imageFromSelfView;

@end
