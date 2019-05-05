//
//  KKTabBar.m
//  KKToydayNews
//
//  Created by finger on 2017/8/6.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKTabBar.h"
#import <objc/runtime.h>

#define MidBtnWH 50
#define MidBtnPadding 5

@interface KKTabBar ()
@property (nonatomic, weak) UIButton *midBtn;
@end

#define USE_MIDBTN FALSE

@implementation KKTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
        
        if (USE_MIDBTN)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn.layer setBorderColor:[UIColor grayColor].CGColor];
            [btn.layer setBorderWidth:0.5];
            [btn.layer setCornerRadius:MidBtnWH / 2.0];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn setImage:[UIImage imageNamed:@"add_channel_titlbar_thin_new_16x16_"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(midBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            self.midBtn = btn;
        }
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    UIView *lastBtn = nil;
    NSInteger btnIndex = 0;
    NSInteger itemCount = USE_MIDBTN ? self.items.count + 1 : self.items.count;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *btn in self.subviews) {
        if ([btn isKindOfClass:class]) {
            btn.width = self.width / itemCount;
            btn.x = btn.width * btnIndex;
            btnIndex++;
            if (USE_MIDBTN && btnIndex == itemCount/2) {
                btnIndex++;
            }
            lastBtn = btn;
        }
    }
    
    if (USE_MIDBTN)
    {
        self.midBtn.size = CGSizeMake(MidBtnWH, MidBtnWH);
        self.midBtn.centerX = self.centerX;
        self.midBtn.centerY = lastBtn.centerY - MidBtnPadding;
        [self bringSubviewToFront:self.midBtn];
    }
}

#pragma mark -- 中间的按钮点击

- (void)midBtnClicked{
    if (USE_MIDBTN && [self.kkTabDelegate respondsToSelector:@selector(tabBarMidBtnClick:)]) {
        [self.kkTabDelegate tabBarMidBtnClick:self];
    }
}

#pragma mark-- 让凸出的部分点击也有反应

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.isHidden == NO) {
        CGPoint newP = [self convertPoint:point toView:self.midBtn];
        if ( [self.midBtn pointInside:newP withEvent:event]) {
            return self.midBtn;
        }else{
            return [super hitTest:point withEvent:event];
        }
    }else {
        return [super hitTest:point withEvent:event];
    }
}

@end
