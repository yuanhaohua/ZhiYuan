//
//  FriendsTableViewCell.h
//  Volunteers
//
//  Created by yuan on 16/5/30.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContactModel;

@interface FriendsTableViewCell : UITableViewCell
@property (nonatomic, strong) ContactModel *model;

+ (CGFloat)fixedHeight;
@end
