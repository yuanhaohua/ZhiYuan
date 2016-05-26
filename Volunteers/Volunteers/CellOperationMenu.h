//
//  CellOperationMenu.h
//  Volunteers
//
//  Created by yuan on 16/5/26.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellOperationMenu : UIView

@property (nonatomic, assign, getter = isShowing) BOOL show;
@property (nonatomic, copy) void (^likeButtonClickedOperation)();
@property (nonatomic, copy) void (^commentButtonClickedOperation)();

@end
