//
//  RefreshHeader.h
//  Volunteers
//
//  Created by yuan on 16/5/26.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "BaseRefreshView.h"
#import <UIKit/UIKit.h>
@interface RefreshHeader : BaseRefreshView

+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;
@property (nonatomic, copy) void(^refreshingBlock)();

@end
