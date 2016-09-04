//
//  WithdrawVC.m
//  deyi
//
//  Created by tomwey on 9/4/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "WithdrawVC.h"
#import "Defines.h"

@interface WithdrawVC ()

@end

@implementation WithdrawVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
    
    BorderAttribute *borderAttribute = BorderAttributeMake(8, MAIN_RED_COLOR, AWHairlineSize());
    AWCustomButton *btn = [[AWCustomButton alloc] initWithTitle:@"test"
                                                borderAttribute:borderAttribute];
    [self.contentView addSubview:btn];
    
    btn.frame = CGRectMake(10, 10, 80, 37);
    
    btn.titleColor = MAIN_RED_COLOR;
    btn.titleFont = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    btn.normalBackgroundColor = [UIColor whiteColor];
    btn.selectedBackgroundColor = MAIN_RED_COLOR;
    
    
}

@end
