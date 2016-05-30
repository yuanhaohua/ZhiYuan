//
//  FriendsSearchResultController.m
//  Volunteers
//
//  Created by yuan on 16/5/30.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import "FriendsSearchResultController.h"

@interface FriendsSearchResultController ()

@end

@implementation FriendsSearchResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat rgb = 0.3;
    self.view.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}


@end
