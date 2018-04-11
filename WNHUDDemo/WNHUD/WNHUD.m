//
//  WNHUD.m
//  WNHUD
//
//  Created by comyn on 2018/4/9.
//  Copyright © 2018年 comyn. All rights reserved.
//

#import "WNHUD.h"
#import "MBProgressHUD.h"

typedef enum : NSUInteger {
    WNHUDModeLoading,
    WNHUDModeInfoMsg,
    WNHUDModeMessage,
    WNHUDModeSuccess,
    WNHUDModeFailure,
} WNHUDMode;

@interface WNHUD ()
@property (nonatomic) NSInteger WNHUDAnimation;
@property (nonatomic) NSInteger WNHUDBackgroundStyle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, strong) UIView *customeView;
@property (nonatomic, assign) CGPoint offset;
@property (nonatomic, strong) MBProgressHUD *HUD;
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
    self.WNHUDAnimation = MBProgressHUDAnimationFade;
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
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeLoading withTitle:string subTitle:nil inView:view];
}
+ (void)showInfoMsg:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeInfoMsg withTitle:string subTitle:nil inView:nil];
}
+ (void)showInfoMsg:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeInfoMsg withTitle:string subTitle:subTitle inView:view];
}
+ (void)showMessage:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeMessage withTitle:string subTitle:nil inView:view];
}
+ (void)showMessage:(NSString *)string withSubTitle:(NSString *)subTitle inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeMessage withTitle:string subTitle:subTitle inView:view];
}
+ (void)showSuccess:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeSuccess withTitle:string subTitle:nil inView:view];
}
+ (void)showFailure:(NSString *)string inView:(UIView *)view {
    [[WNHUD shareInstance] showWNHUDMode:WNHUDModeFailure withTitle:string subTitle:nil inView:nil];
}

#pragma mark - WNHUD显示方式

- (void)showWNHUDMode:(WNHUDMode)mode withTitle:(NSString *)title subTitle:(NSString *)subTitle inView:(UIView *)view
{
    // 如果不为空，说明有创建，先清空再创建
    if (self.HUD) {
        [self hideAfterDelay:0 completion:nil];
        self.HUD = nil;
    }
    self.HUD = [MBProgressHUD showHUDAddedTo:view?view:[UIApplication sharedApplication].keyWindow animated:YES];
    [self.HUD setMinSize:CGSizeMake(100, 100)];//设置最小大小，防止变形
    self.HUD.bezelView.color = [UIColor blackColor];//WNHUD背景色
    self.HUD.contentColor = [UIColor whiteColor];//label等text字体颜色
    self.HUD.label.text = title?title:self.title;
    self.HUD.detailsLabel.text = subTitle?subTitle:self.subTitle;
    if ([self customeView:mode]) {
        self.HUD.customView = [self customeView:mode];
    }

    switch (mode) {
        case WNHUDModeLoading:
            self.HUD.mode = MBProgressHUDModeIndeterminate;
            break;
        case WNHUDModeInfoMsg:
            self.HUD.mode = MBProgressHUDModeCustomView;
            break;
        case WNHUDModeMessage:
            self.HUD.mode = MBProgressHUDModeText;
            break;
        case WNHUDModeSuccess:
            self.HUD.mode = MBProgressHUDModeCustomView;
            break;
        case WNHUDModeFailure:
            self.HUD.mode = MBProgressHUDModeCustomView;
            break;
        default:
            break;
    }
    [self.HUD hideAnimated:YES];
}
#pragma mark - 自定义视图
- (UIView *)customeView:(WNHUDMode)mode {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"WNHUD" ofType:@"bundle"];
    NSString *imageName = @"";
    switch (mode) {
        case WNHUDModeInfoMsg:
            imageName = @"WNHUD_info@2x.png";
            break;
        case WNHUDModeSuccess:
            imageName = @"WNHUD_success@2x.png";
            break;
        case WNHUDModeFailure:
            imageName = @"WNHUD_failure@2x.png";
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
        [self.HUD hideAnimated:YES];
    }else{
        [self.HUD hideAnimated:YES afterDelay:delay];
    }
    completion ? completion = self.HUD.completionBlock : nil;
}

@end
