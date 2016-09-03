//
//  PasswordVC.h
//  deyi
//
//  Created by tomwey on 9/3/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "BaseNavBarVC.h"

typedef NS_ENUM(NSInteger, PasswordType) {
    PasswordTypeForget, // 忘记密码
    PasswordTypeChange, // 修改密码
};

@interface PasswordVC : BaseNavBarVC

- (instancetype)initWithPasswordType:(PasswordType)passwordType;

@end
