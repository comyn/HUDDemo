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
    [self adddView];
}

- (void)adddView {
    [WNHUD showLoading:@"玩命加载" inView:self.view];
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
//        sleep(2);
        dispatch_async(dispatch_get_main_queue(), ^{
            [WNHUD hideAfterDelay:10 completion:^{
                [WNHUD showSuccess:@"success" inView:self.view];
            }];
        });
    });
}
- (void)addKeyWindow {
    [WNHUD showLoading:@"22"];
    //    NSLog(@"%@1",[NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        //        sleep(1);
        //        NSLog(@"%@2",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [WNHUD hide];
            [WNHUD hideAfterDelay:3 completion:^{
                //                NSLog(@"%@3",[NSThread currentThread]);
                
                [WNHUD showSuccess:@"成功"];
                [WNHUD hide];
            }];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
