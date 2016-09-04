//
//  AWCustomButton.h
//  deyi
//
//  Created by tomwey on 9/4/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BorderAttribute;
@interface AWCustomButton : UIView

/** 按钮标题 */
@property (nonatomic, copy) NSString *title;

/** 按钮标题字体，默认为系统字体 */
@property (nonatomic, strong) UIFont *titleFont;

/** 按钮标题颜色, 如果不设置，默认为浅灰色颜色 */
@property (nonatomic, strong) UIColor *titleColor;

/** 按钮默认状态下的背景颜色，默认为白色 */
@property (nonatomic, strong) UIColor *normalBackgroundColor;

/** 按钮选中状态下的背景颜色，默认为标题的颜色 */
@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@property (nonatomic, strong) BorderAttribute *borderAttribute;

/** 设置按钮是否选中, 默认为NO */
@property (nonatomic, assign) BOOL selected;

- (instancetype)initWithTitle:(NSString *)title
              borderAttribute:(BorderAttribute *)borderAttribute;

- (void)addTarget:(id)target action:(SEL)action;

@end

@interface BorderAttribute : NSObject

/** 边框颜色，默认为浅灰色 */
@property (nonatomic, strong, readonly) UIColor *borderColor;

/** 边框大小，默认为头发丝大小 */
@property (nonatomic, assign, readonly) CGFloat borderWidth;

/** 边框倒角大小，默认为8 */
@property (nonatomic, assign, readonly) CGFloat cornerRadius;

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius
                         borderColor:(UIColor *)aColor
                         borderWidth:(CGFloat)width;

@end

BorderAttribute *BorderAttributeMake(CGFloat cornerRadius,
                                     UIColor *borderColor,
                                     CGFloat borderWidth);
