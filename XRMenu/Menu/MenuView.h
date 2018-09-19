//
//  MenuView.h
//  XRMenu
//
//  Created by xurui on 2018/9/18.
//  Copyright © 2018年 zaero. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat buttonHeight = 50.0;

typedef NS_ENUM(NSInteger,MenuViewBtnType){
    
    MenuViewBtnTypeComposite = 100,
    MenuViewBtnTypeSales = 101,
    MenuViewBtnTypePrice = 102,
    MenuViewBtnTypeFlitration = 103
    
};

@interface MenuView : UIView

@end


