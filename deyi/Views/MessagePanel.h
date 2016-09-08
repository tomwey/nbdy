//
//  MessagePanel.h
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagePanel : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong, readonly) UIView *bodyView;

@property (nonatomic, copy) NSString *footerButtonTitle;

@property (nonatomic, copy) void (^messagePanelWillHideCallback)(MessagePanel *sender);
@property (nonatomic, copy) void (^messagePanelDidHideCallback)(MessagePanel *sender);

+ (instancetype)showInView:(UIView *)parentView;

+ (MessagePanel *)showWithTitle:(NSString *)title footerButtonTitle:(NSString *)buttonTitle;

+ (void)hideForView:(UIView *)parentView;

@end
