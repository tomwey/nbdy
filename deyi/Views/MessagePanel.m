//
//  MessagePanel.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "MessagePanel.h"
#import "Defines.h"

@interface MessagePanel ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong, readwrite) UIView *contentView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong, readwrite) UIView *bodyView;

@property (nonatomic, strong) UIButton *footerButton;

@end
@implementation MessagePanel

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        self.frame = AWFullScreenBounds();
        
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.7;
        [self addSubview:self.maskView];
        
        CGRect frame = CGRectMake(0, 0, self.width * 0.8, 232);
        self.contentView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:self.contentView];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.center = CGPointMake(self.width / 2, self.height / 2);
        
        self.contentView.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        
        self.titleLabel = AWCreateLabel(CGRectMake(0, 0, self.contentView.width, 44),
                                        nil,
                                        NSTextAlignmentCenter,
                                        AWCustomFont(MAIN_TEXT_FONT,
                                                     18),
                                        [UIColor whiteColor]);
        [self.contentView addSubview:self.titleLabel];
        self.titleLabel.backgroundColor = MAIN_RED_COLOR;
        
        self.bodyView = [[UIView alloc] init];
        [self.contentView addSubview:self.bodyView];
        self.bodyView.frame = CGRectMake(0, self.titleLabel.bottom,
                                         self.contentView.width,
                                         self.contentView.height - 10 - 44 - 10 - self.titleLabel.bottom);
        
        CGRect frame2 = CGRectMake(0, 0, self.contentView.width - 10 * 2, 44);
        self.footerButton = AWCreateTextButton(frame2,
                                               nil,
                                               [UIColor whiteColor],
                                               self,
                                               @selector(btnClicked));
        [self.contentView addSubview:self.footerButton];
        self.footerButton.center = CGPointMake(self.contentView.width / 2,
                                               self.contentView.height - 10 - self.footerButton.height / 2);
        
        self.footerButton.backgroundColor = MAIN_RED_COLOR;
        self.footerButton.cornerRadius = 8;
        self.footerButton.clipsToBounds = YES;
        
        self.footerButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 15);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.contentView.height = self.titleLabel.height + self.bodyView.height + 10 + 44 + 10;
    self.footerButton.top = self.bodyView.bottom + 10;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setFooterButtonTitle:(NSString *)footerButtonTitle
{
    _footerButtonTitle = footerButtonTitle;
    
    [self.footerButton setTitle:footerButtonTitle forState:UIControlStateNormal];
}

- (void)showInView:(UIView *)superView
{
    if ( !self.superview ) {
        [superView addSubview:self];
    }
    [superView bringSubviewToFront:self];
    
    self.maskView.alpha = 0.0;
    self.contentView.center = CGPointMake(self.width / 2, - self.contentView.height / 2);
    
    AWSetAllTouchesDisabled(YES);
    
    [UIView animateWithDuration:.3 animations:^{
        self.maskView.alpha = 0.7;
        self.contentView.center = CGPointMake(self.width / 2, self.height / 2);
    } completion:^(BOOL finished) {
        AWSetAllTouchesDisabled(NO);
    }];
}

- (void)hide
{
    if (self.messagePanelWillHideCallback) {
        self.messagePanelWillHideCallback(self);
        self.messagePanelWillHideCallback = nil;
    }
    AWSetAllTouchesDisabled(YES);
    [UIView animateWithDuration:.3 animations:^{
        self.maskView.alpha = 0.0;
        self.contentView.center = CGPointMake(self.width / 2, self.height + self.contentView.height / 2);
    } completion:^(BOOL finished) {
        
        if (self.messagePanelDidHideCallback) {
            self.messagePanelDidHideCallback(self);
            self.messagePanelDidHideCallback = nil;
        }
        
        [self removeFromSuperview];
        AWSetAllTouchesDisabled(NO);
    }];
}

+ (instancetype)showInView:(UIView *)parentView
{
    UIView *parent = parentView ?: AWAppWindow();
    
    MessagePanel *panel = [[self alloc] init];
    
    [panel showInView:parent];
    
    return panel;
}

+ (MessagePanel *)showWithTitle:(NSString *)title footerButtonTitle:(NSString *)buttonTitle
{
    MessagePanel *panel = [self showInView:nil];
    panel.title = title;
    panel.footerButtonTitle = buttonTitle;
    return panel;
}

+ (void)hideForView:(UIView *)parentView
{
    UIView *parent = parentView ?: AWAppWindow();
    
    MessagePanel *panel = (MessagePanel *)[parent viewWithTag:123121];
    [panel hide];
}

- (void)btnClicked
{
    [self hide];
}

@end
