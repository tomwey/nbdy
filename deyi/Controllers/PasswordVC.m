//
//  PasswordVC.m
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "PasswordVC.h"
#import "Defines.h"

@interface PasswordVC ()

@property (nonatomic, assign) PasswordType passwordType;

@property (nonatomic, strong) AWTextField *mobileField;
@property (nonatomic, strong) AWTextField *codeField;
@property (nonatomic, strong) AWTextField *passwordField;

@property (nonatomic, strong) UIButton* fetchCodeButton;

@property (nonatomic, strong) NSTimer* countDownTimer;

@property (nonatomic, assign) NSUInteger totalSeconds;

@property (nonatomic, strong) UIScrollView* scrollView;

@property (nonatomic, strong) UIButton *changePasswordButton;

@end

@implementation PasswordVC

- (instancetype)initWithPasswordType:(PasswordType)passwordType
{
    if ( self = [super init] ) {
        self.passwordType = passwordType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.passwordType == PasswordTypeForget ? @"忘记密码" : @"修改密码";
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.scrollView];
    self.scrollView.showsVerticalScrollIndicator = NO;
    
//    CGRect frame = CGRectMake(15, 15, self.contentView.width - 30, 44);
    CGFloat fieldWidth = floorf(self.contentView.width * 0.82);
    CGRect frame = CGRectMake(self.contentView.width / 2 - fieldWidth / 2,
                       self.contentView.width / 2 - fieldWidth / 2,
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
    self.passwordField.placeholder = @"新密码";
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.top = self.codeField.bottom + 15;
    
    self.mobileField.font   =
    self.codeField.font     =
    self.passwordField.font = AWCustomFont(MAIN_DIGIT_FONT, 16);
    
    // 修改密码按钮
    self.changePasswordButton = AWCreateTextButton(self.mobileField.frame, @"修改密码",
                                           [UIColor whiteColor],
                                           self,
                                           @selector(changePassword));
    [self.scrollView addSubview:self.changePasswordButton];
    self.changePasswordButton.backgroundColor = MAIN_RED_COLOR;
    self.changePasswordButton.top = self.passwordField.bottom + 30;
    self.changePasswordButton.cornerRadius = 8;
    
    self.changePasswordButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    // 定时器
    self.countDownTimer = [NSTimer timerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(countDown) userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.countDownTimer
                                 forMode:NSRunLoopCommonModes];
    [self.countDownTimer setFireDate:[NSDate distantFuture]];
    
    [self.scrollView addGestureRecognizer:
     [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 添加通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification object:nil];
}

- (void)hideKeyboard
{
    [self.mobileField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    [self.codeField resignFirstResponder];
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGRect keyboardEndFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect loginBtnFrame = [self.view convertRect:self.changePasswordButton.frame fromView:self.scrollView];
    
    CGFloat dty = CGRectGetMaxY(loginBtnFrame) - CGRectGetMinY(keyboardEndFrame);;
    if ( dty > 0 ) {
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]
                         animations:
         ^{
             self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetMinY(loginBtnFrame) - CGRectGetMinY(keyboardEndFrame) + self.changePasswordButton.height + 5, 0);
             self.scrollView.contentOffset = CGPointMake(0, CGRectGetMinY(loginBtnFrame) - CGRectGetMinY(keyboardEndFrame) + self.changePasswordButton.height + 5 );
         }];
    } else {
        self.scrollView.contentInset = UIEdgeInsetsZero;
        self.scrollView.contentOffset = CGPointZero;
    }
}

- (void)keyboardWillHide:(NSNotification *)noti
{
    if ( self.scrollView.contentInset.bottom > 0 ) {
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]
                         animations:
         ^{
             self.scrollView.contentInset = UIEdgeInsetsZero;
             self.scrollView.contentOffset = CGPointZero;
         }];
    }
}

- (void)fetchCode:(UIButton *)sender
{
    
}

- (void)changePassword
{
    
}

- (void)countDown
{
    
}

@end
