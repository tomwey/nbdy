//
//  PasswordVC.m
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "PasswordVC.h"

@interface PasswordVC ()

@property (nonatomic, assign) PasswordType passwordType;

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
}

@end
