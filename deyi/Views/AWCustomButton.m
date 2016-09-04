//
//  AWCustomButton.m
//  deyi
//
//  Created by tomwey on 9/4/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "AWCustomButton.h"

@interface AWCustomButton ()

@property (nonatomic, weak)   id target;
@property (nonatomic, assign) SEL action;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AWCustomButton

- (instancetype)initWithTitle:(NSString *)title
              borderAttribute:(BorderAttribute *)borderAttribute;
{
    if ( self = [super init] ) {
        
        self.clipsToBounds = YES;
        
        _titleColor = [UIColor lightGrayColor];
        
        self.title           = title;
        self.borderAttribute = borderAttribute;
        self.selected        = NO;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selected = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selected = NO;
    
    if ( [self.target respondsToSelector:self.action] ) {
        [self.target performSelector:self.action withObject:self];
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selected = NO;
}

- (void)addTarget:(id)target action:(SEL)action
{
    self.target = target;
    self.action = action;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    self.titleLabel.text = title;
}

- (void)setBorderAttribute:(BorderAttribute *)borderAttribute
{
    _borderAttribute = borderAttribute;
    
    self.titleLabel.layer.borderWidth = borderAttribute.borderWidth;
    self.titleLabel.layer.borderColor = borderAttribute.borderColor.CGColor;
    self.titleLabel.layer.cornerRadius = borderAttribute.cornerRadius;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    self.titleLabel.font = titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.titleLabel.textColor = titleColor;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    
    [self updateLabelBgColor];
}

- (UILabel *)titleLabel
{
    if ( !_titleLabel ) {
        _titleLabel = [[UILabel alloc] init];
        [self addSubview:_titleLabel];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.frame = self.bounds;
        
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _titleLabel.clipsToBounds = YES;
    }
    return _titleLabel;
}

- (UIColor *)normalBackgroundColor
{
    if ( !_normalBackgroundColor ) {
        _normalBackgroundColor = [UIColor whiteColor];
    }
    return _normalBackgroundColor;
}

- (UIColor *)selectedBackgroundColor
{
    if ( !_selectedBackgroundColor ) {
        _selectedBackgroundColor = self.titleColor;
    }
    return _selectedBackgroundColor;
}

- (void)updateLabelBgColor
{
    self.titleLabel.backgroundColor = self.selected ?
    self.selectedBackgroundColor :
    self.normalBackgroundColor;
    
    self.titleLabel.textColor = self.selected ?
    self.normalBackgroundColor :
    self.selectedBackgroundColor;
}

@end

@interface BorderAttribute ()

/** 边框颜色，默认为浅灰色 */
@property (nonatomic, strong, readwrite) UIColor *borderColor;

/** 边框大小，默认为头发丝大小 */
@property (nonatomic, assign, readwrite) CGFloat borderWidth;

/** 边框倒角大小，默认为8 */
@property (nonatomic, assign, readwrite) CGFloat cornerRadius;

@end

@implementation BorderAttribute

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)aColor borderWidth:(CGFloat)width
{
    if (self = [super init]) {
        self.cornerRadius = cornerRadius;
        self.borderColor = aColor;
        self.borderWidth = width;
    }
    return self;
}

//- (UIColor *)borderColor
//{
//    if ( !_borderColor ) {
//        _borderColor = [UIColor lightGrayColor];
//    }
//    return _borderColor;
//}

- (CGFloat)cornerRadius
{
    if ( _cornerRadius <= 0.0000001 ) {
        _cornerRadius = 0.0;
    }
    return _cornerRadius;
}

- (CGFloat)borderWidth
{
    if ( _borderWidth <= 0.00000001 ) {
        _borderWidth = 8;
    }
    return _borderWidth;
}

@end

BorderAttribute *BorderAttributeMake(CGFloat cornerRadius,
                                     UIColor *borderColor,
                                     CGFloat borderWidth)
{
    return [[BorderAttribute alloc] initWithCornerRadius:cornerRadius
                                             borderColor:borderColor
                                             borderWidth:borderWidth];
};
