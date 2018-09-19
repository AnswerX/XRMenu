//
//  MenuTableView.m
//  XRMenu
//
//  Created by xurui on 2018/9/19.
//  Copyright © 2018年 zaero. All rights reserved.
//

#import "MenuTableView.h"

static NSString  * const cellIdentifier = @"menuCellID";

@interface MenuTableViewCell : UITableViewCell


@end


@implementation MenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 8.2, *)) {
            self.textLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightThin];
        } else {
            // Fallback on earlier versions
            self.textLabel.font = [UIFont systemFontOfSize:12];
            
        }
        self.textLabel.textColor = [UIColor darkTextColor];
    }
    return self;
}

@end


@interface MenuTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSourceArray;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) CellClickBlock cellClickblock;

@end

@implementation MenuTableView

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.dataSourceArray = dataArray;
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self.tableView setFrame:self.bounds];

    [self addSubview:self.tableView];

}
-(void)layoutSubviews {
    
    [self.tableView setFrame:self.bounds];

    [super layoutSubviews];
}

- (void)setCellClickblock:(CellClickBlock)cellClickblock {
    
    _cellClickblock = cellClickblock;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = self.dataSourceArray[indexPath.row];
    
    return cell;
}

- (void)reloadmenuTableView {
    
    [self.tableView reloadData];
}
#pragma mark - UITableViewDelegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选择了%@",self.dataSourceArray[indexPath.row]);
    
    if (self.cellClickblock) {
        self.cellClickblock(self.dataSourceArray[indexPath.row]);
        
    }
}



- (UITableView *)tableView {
   
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 44;
        _tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[MenuTableViewCell class] forCellReuseIdentifier:cellIdentifier];
        tableView.tableFooterView = [UIView new];

        _tableView = tableView;
    }

    return _tableView;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
