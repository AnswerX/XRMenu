//
//  MenuView.m
//  XRMenu
//
//  Created by xurui on 2018/9/18.
//  Copyright © 2018年 zaero. All rights reserved.
//


#import "MenuView.h"
#import "MenuTableView.h"


@interface MenuView ()

@property (nonatomic, strong) NSMutableArray * titleArray;
@property (nonatomic, strong) NSMutableArray *subTitleArray;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonArray;
@property (nonatomic, assign) BOOL showTableView;

@property (nonatomic, strong) MenuTableView *tableView;
@property (nonatomic, strong) UIButton *compositeBtn;//综合按钮

@end




@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self configurePropertys];

    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self configurePropertys];
    }
    return self;
    
}

- (void)configurePropertys {
    
    _titleArray = @[@"综合",@"销量",@"价格",@"筛选"].mutableCopy;
    _subTitleArray = @[@"综合排序",@"新品优先",@"评论数从高到低"].mutableCopy;
    _buttonArray = [NSMutableArray array];
    _showTableView = NO;
    [self setupSubviews];
}

#pragma mark - 添加子视图
- (void)setupSubviews {
    
    NSAssert(_titleArray.count > 0, @"父菜单没有数据");
    NSAssert(_subTitleArray.count > 0, @"子菜单没有数据");
    
    CGFloat buttonWidth = self.frame.size.width/_titleArray.count;
    for (NSInteger i = 0 ; i<_titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];
        [button setTag:i+100];
        
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        if (@available(iOS 8.2, *)) {
            button.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
        } else {
            // Fallback on earlier versions
            button.titleLabel.font = [UIFont systemFontOfSize:14];
        }
        [button addTarget:self action:@selector(btnClickedHandler:) forControlEvents:UIControlEventTouchUpInside];

        [self.buttonArray addObject:button];
        
        [self addSubview:button];
        
        if (button.tag == MenuViewBtnTypeComposite) {
            self.compositeBtn = button;
        }
    }
    
    [self addSubview:self.tableView];
    
    [self.tableView reloadmenuTableView];
    
}

- (void)layoutSubviews {
    NSAssert(self.buttonArray.count>0, @"没有菜单数据");
    
    CGFloat buttonWidth = self.frame.size.width/self.buttonArray.count;

    for (NSInteger i = 0; i<self.buttonArray.count; i++) {

        UIButton *btn = self.buttonArray[i];

        [btn setFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];

    }

    if (_showTableView) {
        [self.tableView setFrame:CGRectMake(0, buttonHeight, self.frame.size.width, cellHeight*self.subTitleArray.count)];

    }
    
    [super layoutSubviews];

}

- (void)btnClickedHandler:(UIButton *)btn {
    
    for (UIButton *tempBtn in self.buttonArray) {
        [tempBtn setSelected:(tempBtn.tag == btn.tag)];
    }
    
    [btn setSelected:YES];
    
    if (btn.tag == MenuViewBtnTypeComposite) {
       self.showTableView = !self.showTableView;
        
    }else if (btn.tag == MenuViewBtnTypeSales){
        
        
    }else if (btn.tag == MenuViewBtnTypePrice){
        
    }else if (btn.tag == MenuViewBtnTypeFlitration){
        
        
    }
    
    if (btn.tag!=MenuViewBtnTypeComposite && self.showTableView) {
        self.showTableView = NO;
    }
    
    
}

- (void)setShowTableView:(BOOL)showTableView {
    
    _showTableView = showTableView;

    if (_showTableView) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            [self.tableView setFrame:CGRectMake(0, buttonHeight, self.frame.size.width, cellHeight*self.subTitleArray.count)];
            self.tableView.backgroundColor = [UIColor redColor];

        } completion:^(BOOL finished) {
            
        }];
    }else {
        [UIView animateWithDuration:0.3 animations:^{
            
        [self.tableView setFrame:CGRectMake(0, buttonHeight, self.frame.size.width, 0)];
            
            [self.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}



#pragma mark - getters

- (MenuTableView *)tableView {
    
    if (!_tableView) {
        MenuTableView *tableView = [[MenuTableView alloc] initWithFrame:CGRectMake(0, buttonHeight, self.frame.size.width, 0) dataArray:_subTitleArray];
        __weak typeof(self)weakSelf = self;
        [tableView setCellClickblock:^(NSString *name) {
            [weakSelf.compositeBtn setTitle:name forState:UIControlStateNormal];
        }];

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
