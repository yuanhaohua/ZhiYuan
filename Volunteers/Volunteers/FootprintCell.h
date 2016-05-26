//
//  FootprintCell.h
//  Volunteers
//
//  Created by yuan on 16/5/26.
//  Copyright © 2016年 yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FootprintCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class CellModel;

@interface FootprintCell : UITableViewCell

@property (nonatomic, weak) id<FootprintCellDelegate> delegate;

@property (nonatomic, strong) CellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);

@end

