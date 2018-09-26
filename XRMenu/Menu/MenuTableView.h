//
//  MenuTableView.h
//  XRMenu
//
//  Created by xurui on 2018/9/19.
//  Copyright © 2018年 zaero. All rights reserved.
//

#import <UIKit/UIKit.h>
static const CGFloat cellHeight = 44.0;

typedef void(^CellClickBlock)(NSString *name);

@interface MenuTableView : UIView

@property (nonatomic, strong) UITableView *tableView;


- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray;

- (void)setCellClickblock:(CellClickBlock)cellClickblock;


/**
 刷新Table的数据
 */
- (void)reloadMenuTableView;

@end


