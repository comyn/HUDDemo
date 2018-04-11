//
//  HUD.m
//  HUD
//
//  Created by comyn on 2018/4/9.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import "WNHUD.h"
#import "MBProgressHUD.h"

typedef enum : NSUInteger {
    HUDModeLoading,
    HUDModeInfoMsg,
    HUDModeMessage,
    HUDModeSuccess,
    HUDModeFailure,
} HUDMode;

@interface WNHUD ()
@property (nonatomic) NSInteger HUDAnimation;
@property (nonatomic) NSInteger HUDBackgroundStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) UIView *customeView;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation WNHUD

+ (instancetype)shareInstance {
    static WNHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.title = nil;
    self.subTitle = nil;
    self.customeView = nil;
    self.offset = CGPointMake(10, 10);
    self.HUDAnimation = MBProgressHUDAnimationFade;
}

#pragma mark -- 添加到window上

+ (void)showLoading {
    [WNHUD showLoading:nil];
}

+ (void)showLoading:(NSString *)string {
    [WNHUD showLoading:string inView:nil];
}

+ (void)showInfoMsg:(NSString *)string {
    [WNHUD showInfoMsg:string inView:nil];
}

+ (void)showInfoMsg:(NSString *)string withSubTitle:(NSString *)subTitle {
    [WNHUD showInfoMsg:string withSubTitle:subTitle inView:nil];
}

+ (void)showMessage:(NSString *)string {
    [WNHUD showMessage:string inView:nil];
}

+ (void)showMessage:(NSString *)string withSubTitle:(NSString *)subTitle {
    [WNHUD showMessage:string withSubTitle:subTitle inView:nil];
}

+ (void)showSuccess:(NSString *)string {
    [WNHUD showSuccess:string inView:nil];
}

+ (void)showFailure:(NSString *)string {
    [WNHUD showFailure:string inView:nil];
}

#pragma mark - 添加到指定视图上

+ (void)showLoadingInView:(UIView *)view {
    [WNHUD showLoading:nil inView:view];
}
+ (void)showLoading:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeLoading withTitle:string subTitle:nil inView:view];
}
+ (void)showInfoMsg:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeInfoMsg withTitle:string subTitle:nil inView:nil];
}
+ (void)showInfoMsg:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeInfoMsg withTitle:string subTitle:subTitle inView:view];
}
+ (void)showMessage:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeMessage withTitle:string subTitle:nil inView:view];
}
+ (void)showMessage:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeMessage withTitle:string subTitle:subTitle inView:view];
}
+ (void)showSuccess:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeSuccess withTitle:string subTitle:nil inView:view];
}
+ (void)showFailure:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showHUDMode:HUDModeFailure withTitle:string subTitle:nil inView:nil];
}

#pragma mark - hud显示方式

- (void)showHUDMode:(HUDMode)mode withTitle:(NSString *)title subTitle:(NSString *)subTitle inView:(UIView *)view
{
    // 如果不为空，说明有创建，先清空再创建
    if (self.hud) {
        [self hideAfterDelay:0 completion:nil];
    }
    self.hud = [MBProgressHUD showHUDAddedTo:view?view:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.hud setMinSize:CGSizeMake(100, 100)];//设置最小大小，防止变形
    self.hud.bezelView.color = [UIColor blackColor];//hud背景色
    self.hud.contentColor = [UIColor whiteColor];//label等text字体颜色
    self.hud.label.text = title?title:self.title;
    self.hud.detailsLabel.text = subTitle?subTitle:self.subTitle;
    if ([self customeView:mode]) {
        self.hud.customView = [self customeView:mode];
    }

    switch (mode) {
        case HUDModeLoading:
            self.hud.mode = MBProgressHUDModeIndeterminate;
            break;
        case HUDModeInfoMsg:
            self.hud.mode = MBProgressHUDModeCustomView;
            break;
        case HUDModeMessage:
            self.hud.mode = MBProgressHUDModeText;
            break;
        case HUDModeSuccess:
            self.hud.mode = MBProgressHUDModeCustomView;
            break;
        case HUDModeFailure:
            self.hud.mode = MBProgressHUDModeCustomView;
            break;
        default:
            break;
    }
//    [self.hud hideAnimated:YES];
}

#pragma mark - 自定义视图
- (UIView *)customeView:(HUDMode)mode {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"HUD" ofType:@"bundle"];
    NSString *imageName = @"";
    switch (mode) {
        case HUDModeInfoMsg:
            imageName = @"hud_info@2x.png";
            break;
        case HUDModeSuccess:
            imageName = @"hud_success@2x.png";
            break;
        case HUDModeFailure:
            imageName = @"hud_failure@2x.png";
            break;
        default:
            break;
    }
    NSString *path = [bundlePath stringByAppendingPathComponent:imageName];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *view = [[UIImageView alloc] initWithImage:image];
    return view;
}

+ (void)hide {
    [WNHUD hideAfterDelay:1.5f completion:nil];
}

+ (void)hideAfterDelay:(NSTimeInterval)delay completion:(void(^)(void))completion {
    [[WNHUD shareInstance] hideAfterDelay:delay completion:completion];
}

- (void)hideAfterDelay:(NSTimeInterval)delay completion:(void(^)(void))completion {
    if (delay==-1) {
        [self.hud hideAnimated:YES];
    }else{
        [self.hud hideAnimated:YES afterDelay:delay];
    }
    
    if (completion) {
        self.hud.completionBlock = completion;
    }
    self.hud = nil;

}

@end
