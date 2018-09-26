//
//  MenuView.m
//  XRMenu
//
//  Created by xurui on 2018/9/18.
//  Copyright © 2018年 zaero. All rights reserved.
//


#import "MenuView.h"
#import "MenuTableView.h"
#define MenuTableViewY CGRectGetMaxY(self.frame)

@interface MenuView ()

@property (nonatomic, strong) NSMutableArray * titleArray;
@property (nonatomic, strong) NSMutableArray *subTitleArray;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttonArray;
@property (nonatomic, assign) BOOL showTableView;

@property (nonatomic, strong) MenuTableView *menuTableView;
@property (nonatomic, strong) UIButton *compositeBtn;//综合按钮
@property (nonatomic, strong) UIView *coverView;//背景视图
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
            [button setImage:[UIImage imageNamed:@"down_black"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"down_red"] forState:UIControlStateSelected];
            [button setSelected:YES];
        }
    }
    

    
}

- (void)layoutSubviews {
    
    NSAssert(self.buttonArray.count>0, @"没有菜单数据");
    
    CGFloat buttonWidth = self.frame.size.width/self.buttonArray.count;
    for (NSInteger i = 0; i<self.buttonArray.count; i++) {

        UIButton *btn = self.buttonArray[i];
        [btn setFrame:CGRectMake(i*buttonWidth, 0, buttonWidth, buttonHeight)];

    }

    if (_showTableView) {
        
        [self.menuTableView setFrame:CGRectMake(0, MenuTableViewY, self.frame.size.width, cellHeight*self.subTitleArray.count)];
        
        [self.coverView setFrame:CGRectMake(0, CGRectGetMaxY(self.menuTableView.frame), self.frame.size.width, self.superview.frame.size.height-CGRectGetMaxY(self.menuTableView.frame))];
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
#pragma mark - 隐藏 or 显示 列表数据
- (void)setShowTableView:(BOOL)showTableView {
    
    _showTableView = showTableView;
    
    if (_showTableView) {
        
        [self.superview addSubview:self.coverView];
        [self.coverView setFrame:CGRectMake(0, CGRectGetMaxY(self.menuTableView.frame), self.frame.size.width, self.superview.frame.size.height-CGRectGetMaxY(self.menuTableView.frame))];

        self.coverView.alpha = 0;
        
        [self.superview addSubview:self.menuTableView];
        
        
        [UIView animateWithDuration:0.3 animations:^{
            self.compositeBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);

            [self.menuTableView setFrame:CGRectMake(0, MenuTableViewY, self.frame.size.width, cellHeight*self.subTitleArray.count)];
            
            self.coverView.alpha = 1;

            [self.menuTableView.superview layoutIfNeeded];

        }];
        
    }else {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.coverView.alpha = 0;

        [self.menuTableView setFrame:CGRectMake(0, MenuTableViewY, self.frame.size.width, 0)];
            self.compositeBtn.imageView.transform = CGAffineTransformMakeRotation(2*M_PI);
            [self.menuTableView.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
             [self.menuTableView removeFromSuperview];
            [self.coverView removeFromSuperview];
        }];
    }
}

#pragma mark - 隐藏列表数据
- (void)coverViewClicked {
    
    self.showTableView = NO;
}

#pragma mark - getters

- (MenuTableView *)menuTableView {
    
    if (!_menuTableView) {
        

        MenuTableView *menuTableView = [[MenuTableView alloc] initWithFrame:CGRectMake(0, MenuTableViewY, self.frame.size.width, 0) dataArray:_subTitleArray];
        
        [menuTableView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        __weak typeof(self)weakSelf = self;
        [menuTableView setCellClickblock:^(NSString *name) {
            [weakSelf.compositeBtn setTitle:name forState:UIControlStateNormal];
            weakSelf.showTableView = NO;
         
        }];
        
        _menuTableView = menuTableView;
    }
    return _menuTableView;
}

- (UIView *)coverView {
    
    if (!_coverView) {
        UIControl *coverView = [[UIControl alloc] initWithFrame:CGRectZero];
        coverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [coverView addTarget:self action:@selector(coverViewClicked) forControlEvents:UIControlEventTouchUpInside];
        _coverView = coverView;
        
    }
    return _coverView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
