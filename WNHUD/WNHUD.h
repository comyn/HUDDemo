//
//  HUD.h
//  HUD
//
//  Created by comyn on 2018/4/9.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WNHUD : NSObject

+ (instancetype)shareInstance;

/**
 加载菊花
 */
+ (void)showLoading;

/**
 加载菊花+提示内容

 @param string 提示内容小标题
 */
+ (void)showLoading:(NSString *)string;

/**
 提示图标+提示内容

 @param string 提示内容小标题
 */
+ (void)showInfoMsg:(NSString *)string;

/**
 提示图标+提示内容

 @param string 提示内容小标题
 @param subTitle 提示内容详细信息
 */
+ (void)showInfoMsg:(NSString *)string withSubTitle:(NSString *)subTitle;

/**
 提示内容

 @param string 提示内容小标题
 */
+ (void)showMessage:(NSString *)string;

/**
 提示内容

 @param string 提示内容小标题
 @param subTitle 提示内容详细信息
 */
+ (void)showMessage:(NSString *)string withSubTitle:(NSString *)subTitle;

/**
 提示成功

 @param string 提出内容小标题
 */
+ (void)showSuccess:(NSString *)string;

/**
 提示失败

 @param string 提示内容小标题
 */
+ (void)showFailure:(NSString *)string;

/*******************inView 加载到指定视图上 ***********************************/

+ (void)showLoadingInView:(UIView *)view;
+ (void)showLoading:(NSString *)string inView:(UIView *)view;
+ (void)showInfoMsg:(NSString *)string inView:(UIView *)view;
+ (void)showInfoMsg:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view;
+ (void)showMessage:(NSString *)string inView:(UIView *)view;
+ (void)showMessage:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view;
+ (void)showSuccess:(NSString *)string inView:(UIView *)view;
+ (void)showFailure:(NSString *)string inView:(UIView *)view;

/**
 隐藏HUD 默认1.5S
 */
+ (void)hide;

/**
 隐藏HUD

 @param delay HUD显示时长
 @param completion 完成后回调
 */
+ (void)hideAfterDelay:(NSTimeInterval)delay completion:(void(^)(void))completion;
@end
