//
//  NavigationBar.m
//  Volunteer
//
//  Created by l k j y on 16/5/25.
//  Copyright © 2016年 康康. All rights reserved.
//

#import "NavigationBar.h"
#import <QuartzCore/QuartzCore.h>
@implementation NavigationBar


static CGFloat kEndPoint = 1.5;

-(void)awakeFromNib
{
    [super awakeFromNib];
    if (self.color)
    {
        [self setNavigationBarWithColor:self.color];
    }else
    {
        [self setNavigationBarWithColor:[UIColor whiteColor]];
    }
}

void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor)

{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations [] = {0.0,1.0};
    NSArray *colors = @[(__bridge id)startColor,(__bridge id)endColor];
   CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGPoint stratPoint = CGPointMake(rect.size.width/2, 0);
    CGPoint endPoint = CGPointMake(rect.size.width/2.0, rect.size.height/kEndPoint);
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, stratPoint, endPoint, 0);
    CGContextSetStrokeColorWithColor(context, [[UIColor clearColor]CGColor ]);
    
}
-(UIImage *)imageWithColor:(UIColor*)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(UIImage*)imageWithGradients:(NSArray *)colors
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor *beginColor = [colors objectAtIndex:0];
    UIColor *endColor = [colors objectAtIndex:1];
    drawLinearGradient(context, rect, beginColor.CGColor, endColor.CGColor);
    CGContextRestoreGState(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;

}

-(void)setNavigationBarWithColor:(UIColor *)color
{
    UIImage *image = [self imageWithColor:color];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setTintColor:[UIColor whiteColor]];
    [self setTranslucent:NO];
}
-(void)setNavigationNarWithColors:(NSArray *)colors
{
    UIImage *image = [self imageWithGradients:colors];
    [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self setBarStyle:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self setTintColor:[UIColor whiteColor]];
    [self setTranslucent:NO];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
