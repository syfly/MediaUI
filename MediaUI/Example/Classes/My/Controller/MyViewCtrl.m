//
//  MyViewCtrl.m
//  MediaUI_Example
//
//  Created by ts on 2019/5/4.
//  Copyright © 2019年 ts. All rights reserved.
//

#import "MyViewCtrl.h"
#import "KKUserCenterView.h"

@implementation MyViewCtrl

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
        KKUserCenterView *centerView = [KKUserCenterView new];
        centerView.topSpace = 0 ;
        centerView.enableFreedomDrag = NO ;
        centerView.enableVerticalDrag = NO ;
        centerView.enableHorizonDrag = YES ;
    
        [self.view addSubview:centerView];
        [centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(UIDeviceScreenWidth, UIDeviceScreenHeight));
        }];
        [centerView pushIn];
        [centerView setBackViewHidder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

@end
