//
//  ViewController.m
//  XRMenu
//
//  Created by xurui on 2018/9/18.
//  Copyright © 2018年 zaero. All rights reserved.
//

#import "ViewController.h"
#import "Menu/MenuView.h"
@interface ViewController ()

@property (nonatomic, strong) MenuView *menuView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MenuView *menu = [[MenuView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, buttonHeight)];
    self.menuView = menu;
    [self.view addSubview:self.menuView];
    self.view.backgroundColor = [UIColor yellowColor];
}

-(void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CGFloat menuWidth =  [UIDevice currentDevice].orientation == (UIDeviceOrientationLandscapeLeft | UIDeviceOrientationLandscapeRight)?self.view.frame.size.height:self.view.frame.size.width;
    [self.menuView setFrame:CGRectMake(0, 80, menuWidth, buttonHeight)];
    

}

@end
