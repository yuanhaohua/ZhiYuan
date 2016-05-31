//
//  NavigationBar.h
//  Volunteer
//
//  Created by l k j y on 16/5/25.
//  Copyright © 2016年 康康. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface NavigationBar : UINavigationBar

@property (strong ,nonatomic) IBInspectable UIColor *color;

-(void)setNavigationBarWithColor:(UIColor*)color;
-(void)setNavigationNarWithColors:(NSArray*)colors;

@end
