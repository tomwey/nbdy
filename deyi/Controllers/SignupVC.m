//
//  SignupVC.m
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "SignupVC.h"
#import "Defines.h"

@interface SignupVC ()

@property (nonatomic, strong) AWTextField* mobileField;
@property (nonatomic, strong) AWTextField* codeField;
@property (nonatomic, strong) AWTextField* passwordField;
@property (nonatomic, strong) AWTextField* inviteCodeField;

@property (nonatomic, strong) UIButton* fetchCodeButton;
@property (nonatomic, strong) UIButton* signupButton;

@property (nonatomic, strong) NSTimer* countDownTimer;

@property (nonatomic, assign) NSUInteger totalSeconds;

@property (nonatomic, strong) UIScrollView* scrollView;

@end

@implementation SignupVC

- (void)dealloc
{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.scrollView];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // 创建logo
    CGRect frame = CGRectMake(0, 18, self.contentView.width, 44);
    UILabel *logoLabel = AWCreateLabel(frame, @"用得益，更得意！",
                                       NSTextAlignmentCenter,
                                       AWCustomFont(MAIN_TEXT_FONT, 20),
                                       MAIN_RED_COLOR);
    [self.scrollView addSubview:logoLabel];
    
    CGFloat fieldWidth = floorf(self.contentView.width * 0.82);
    frame = CGRectMake(self.contentView.width / 2 - fieldWidth / 2,
                       logoLabel.bottom + 20,
                       fieldWidth,
                       44);
    
    // 手机
    self.mobileField = [[AWTextField alloc] initWithFrame:frame];
    [self.scrollView addSubview:self.mobileField];
    self.mobileField.placeholder = @"手机号";
    self.mobileField.keyboardType = UIKeyboardTypeNumberPad;
    
    // 验证码
    self.codeField = [[AWTextField alloc] initWithFrame:self.mobileField.frame];
    
    self.codeField.width = self.codeField.width * 0.58;
    self.codeField.top = self.mobileField.bottom + 15;
    
    [self.scrollView addSubview:self.codeField];
    self.codeField.placeholder = @"手机验证码";
    self.codeField.keyboardType = UIKeyboardTypeNumberPad;
    
    // 获取验证码按钮
    self.fetchCodeButton = AWCreateTextButton(self.mobileField.frame,
                                              @"获取验证码",
                                              MAIN_RED_COLOR,
                                              self,
                                              @selector(fetchCode:));
    [self.scrollView addSubview:self.fetchCodeButton];
    self.fetchCodeButton.backgroundColor = [UIColor whiteColor];
    self.fetchCodeButton.top = self.codeField.top;
    self.fetchCodeButton.left = self.codeField.right + 10;
    self.fetchCodeButton.width = self.mobileField.width  - 10 - self.codeField.width;
    
    self.fetchCodeButton.cornerRadius = 8;
    self.fetchCodeButton.layer.borderColor = MAIN_RED_COLOR.CGColor;
    self.fetchCodeButton.layer.borderWidth = AWHairlineSize();
    
    self.fetchCodeButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    // 密码
    self.passwordField = [[AWTextField alloc] initWithFrame:self.mobileField.frame];
    [self.scrollView addSubview:self.passwordField];
    self.passwordField.placeholder = @"密码";
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.top = self.codeField.bottom + 15;
    
    // 邀请码
    self.inviteCodeField = [[AWTextField alloc] initWithFrame:self.mobileField.frame];
    [self.scrollView addSubview:self.inviteCodeField];
    self.inviteCodeField.placeholder = @"邀请码（可选）";
    self.inviteCodeField.keyboardType = UIKeyboardTypePhonePad;
    
    self.inviteCodeField.top = self.passwordField.bottom + 15;
    
    self.mobileField.font   =
    self.codeField.font     =
    self.inviteCodeField.font =
    self.passwordField.font = AWCustomFont(MAIN_DIGIT_FONT, 16);
    
    // 注册按钮
    self.signupButton = AWCreateTextButton(self.mobileField.frame, @"注册",
                                            [UIColor whiteColor],
                                            self,
                                            @selector(signup));
    [self.scrollView addSubview:self.signupButton];
    self.signupButton.backgroundColor = MAIN_RED_COLOR;
    self.signupButton.top = self.inviteCodeField.bottom + 30;
    self.signupButton.cornerRadius = 8;
    
    self.signupButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    // 定时器
    self.countDownTimer = [NSTimer timerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown) userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer
                                 forMode:NSRunLoopCommonModes];
    [self.countDownTimer setFireDate:[NSDate distantFuture]];
    
    // 自动滚动管理器
    [[AWKeyboardManager sharedInstance] setAutoScrollUITextFieldsContainer:self.scrollView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 添加键盘通知
    [[AWKeyboardManager sharedInstance] registerKeyboardNotification];
    
    [[AWKeyboardManager sharedInstance] addAutoScrollUITextFields:
     @[self.mobileField, self.codeField, self.passwordField]];
    
    [[AWKeyboardManager sharedInstance] addLastAutoScrollUITextField:self.inviteCodeField extraOffset:30 + 44];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 移除键盘通知
    [[AWKeyboardManager sharedInstance] unregisterKeyboardNotification];
    
    [[AWKeyboardManager sharedInstance] removeAutoScrollUITextFields:
     @[self.mobileField, self.codeField, self.passwordField]];
    
    [[AWKeyboardManager sharedInstance] removeLastAutoScrollUITextField:self.inviteCodeField];
}

- (void)countDown
{
    
}

- (void)signup
{
    
}

- (void)fetchCode:(UIButton *)sender
{
    
}

@end
