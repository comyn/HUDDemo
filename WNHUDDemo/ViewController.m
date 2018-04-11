//
//  ViewController.m
//  HUD
//
//  Created by comyn on 2018/4/9.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import "ViewController.h"
#import "WNHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WNHUD showLoading];
        [WNHUD hideAfterDelay:5 completion:^{
            [WNHUD showSuccess:@"成功"];

        }];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
