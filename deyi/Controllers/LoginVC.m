//
//  LoginVC.m
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "LoginVC.h"
#import "Defines.h"

@interface LoginVC ()

@property (nonatomic, strong) UITextField* mobileField;
@property (nonatomic, strong) UITextField* passwordField;

@property (nonatomic, weak) UIButton* loginButton;
@property (nonatomic, weak) UIScrollView* scrollView;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    [self addLeftBarItemWithImage:nil callback:nil];
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    // 新建容器
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:scrollView];
    scrollView.showsVerticalScrollIndicator = NO;
    
    self.scrollView = scrollView;
    self.scrollView.contentSize = self.scrollView.frame.size;
    //    self.scrollView.backgroundColor = [UIColor redColor];
    
    // 创建logo
    CGRect frame = CGRectMake(0, 18, self.contentView.width, 44);
    UILabel *logoLabel = AWCreateLabel(frame, @"用得益，更得意！",
                                       NSTextAlignmentCenter,
                                       AWCustomFont(MAIN_TEXT_FONT, 20),
                                       MAIN_RED_COLOR);
    [self.scrollView addSubview:logoLabel];
    
    frame = CGRectMake(15, logoLabel.bottom + 20,
                       self.contentView.width - 30,
                       44);
    
    self.mobileField = [[AWTextField alloc] initWithFrame:frame];
    [scrollView addSubview:self.mobileField];
    self.mobileField.placeholder = @"手机号";
    self.mobileField.keyboardType = UIKeyboardTypeNumberPad;
    
    // 密码
    self.passwordField = [[AWTextField alloc] initWithFrame:self.mobileField.frame];
    [scrollView addSubview:self.passwordField];
    self.passwordField.placeholder = @"密码";
    self.passwordField.secureTextEntry = YES;
    
    self.passwordField.top = self.mobileField.bottom + 15;
    
    self.mobileField.font   =
    self.passwordField.font = AWCustomFont(MAIN_DIGIT_FONT, 16);
    
    // 登陆按钮
    UIButton* loginBtn = AWCreateTextButton(self.mobileField.frame, @"登录",
                                            [UIColor whiteColor],
                                            self,
                                            @selector(login));
    [scrollView addSubview:loginBtn];
    loginBtn.backgroundColor = MAIN_RED_COLOR;
    loginBtn.frame = self.passwordField.frame;
    loginBtn.top = self.passwordField.bottom + 30;
    loginBtn.cornerRadius = 8;
    
    self.loginButton = loginBtn;
    
    loginBtn.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    // 注册按钮
    CGFloat width = ( self.contentView.width - 3 * loginBtn.left ) / 2;
    UIButton* signupBtn = AWCreateTextButton(CGRectMake(0, 0, width, loginBtn.height),
                                             @"免费注册",
                                             MAIN_RED_COLOR, self,
                                             @selector(gotoSignup));
    [scrollView addSubview:signupBtn];
    signupBtn.position = CGPointMake(loginBtn.left, loginBtn.bottom + 15);
    
    signupBtn.cornerRadius = 8;
    signupBtn.layer.borderColor = MAIN_RED_COLOR.CGColor;
    signupBtn.layer.borderWidth = AWHairlineSize();
    
    // 忘记密码按钮
    UIButton* pwdBtn = AWCreateTextButton(signupBtn.frame,
                                          @"忘记密码",
                                          MAIN_RED_COLOR, self,
                                          @selector(forgetPassword));
    [scrollView addSubview:pwdBtn];
    pwdBtn.left = signupBtn.right + signupBtn.left;
    
    pwdBtn.cornerRadius = signupBtn.cornerRadius;
    pwdBtn.layer.borderColor = signupBtn.layer.borderColor;
    pwdBtn.layer.borderWidth = signupBtn.layer.borderWidth;
    
    signupBtn.titleLabel.font =
    pwdBtn.titleLabel.font    = loginBtn.titleLabel.font;
    
    // 添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [scrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]];
    
}

- (void)keyboardWillShow:(NSNotification *)noti
{
    CGRect keyboardEndFrame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect loginBtnFrame = [self.view convertRect:self.loginButton.frame fromView:self.scrollView];
    
    CGFloat dty = CGRectGetHeight(loginBtnFrame) - CGRectGetHeight(keyboardEndFrame);
    if ( dty < 0 ) {
        [UIView animateWithDuration:[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue]
                         animations:
         ^{
             self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, CGRectGetMinY(loginBtnFrame) - CGRectGetMinY(keyboardEndFrame) + self.loginButton.height + 5, 0);
             self.scrollView.contentOffset = CGPointMake(0, CGRectGetMinY(loginBtnFrame) - CGRectGetMinY(keyboardEndFrame) + self.loginButton.height + 5 );
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

- (void)hideKeyboard
{
    [self.mobileField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (void)forgetPassword
{
    UIViewController *vc =
    [[AWMediator sharedInstance] openVCWithName:@"PasswordVC"
                                         params:@{ @"passwordType": @(0) }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoSignup
{
    UIViewController *vc =
    [[AWMediator sharedInstance] openVCWithName:@"SignupVC"
                                         params:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)login
{
    
}

@end
