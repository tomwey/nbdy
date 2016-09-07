//
//  AdCell.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AdCell.h"
#import "Defines.h"

@interface AdCell ()

@property (nonatomic, strong) UIImageView *thumbView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *plusSymbolLabel;
@property (nonatomic, strong) UILabel *earnLabel;

@property (nonatomic, strong) UIImageView *locationIconView;
@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIView *contentContainerView;

@end

#define kLeftMargin 15

@implementation AdCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self removeBackground];
    }
    return self;
}

- (void)configData:(id)data
{
    NSURL *imageURL = [NSURL URLWithString:[data valueForKey:@"cover_image"]];
    [self.thumbView setImageWithURL:imageURL];
    
    // 标题
    self.titleLabel.text = [data valueForKey:@"title"];
    
    // 价钱
    self.earnLabel.text = [[data valueForKey:@"price"] description];
    
    // 距离
    CGFloat distance = [[data valueForKey:@"distance"] floatValue];
    NSString *distanceFormatString = distance < 1000 ?
    [NSString stringWithFormat:@"%d米", (int)distance] :
    [NSString stringWithFormat:@"%.1f千米", distance / 1000.0];
    self.locationLabel.text = distanceFormatString;
    
    [self.locationLabel sizeToFit];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.thumbView.frame = CGRectMake(0,
                                      0,
                                      [[self class] thumbViewSize].width,
                                      [[self class] thumbViewSize].height);
    self.thumbView.position = CGPointMake(kLeftMargin, kLeftMargin);
    
    self.titleLabel.frame = CGRectMake(self.thumbView.left,
                                       self.thumbView.bottom + 10,
                                       self.thumbView.width,
                                       34);
    
    self.earnLabel.frame = CGRectMake(self.thumbView.left + self.plusSymbolLabel.width + 3,
                                      self.titleLabel.bottom,
                                      120, 34);
    self.plusSymbolLabel.center = CGPointMake(self.thumbView.left + self.plusSymbolLabel.width / 2,
                                                self.earnLabel.midY);
    
    self.locationLabel.center = CGPointMake(self.width - self.thumbView.left - self.locationLabel.width / 2,
                                            self.earnLabel.midY);
    self.locationIconView.center = CGPointMake(self.locationLabel.left - 5 - self.locationIconView.width / 2,
                                               self.locationLabel.midY);
    self.contentContainerView.height = self.earnLabel.bottom + 5;
}

+ (CGSize)thumbViewSize
{
    static CGSize size;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat width = AWFullScreenWidth() - kLeftMargin * 2;
        CGFloat height = width * 512.0 / 750.0;
        size = CGSizeMake(width, height);
    });
    return size;
}

+ (CGFloat)cellHeight
{
    CGFloat thumbHeight = [self thumbViewSize].height;
    return thumbHeight + 34 + 10 + 34 + 5 + kLeftMargin;
}

- (UIImageView *)thumbView
{
    if ( !_thumbView ) {
        _thumbView = AWCreateImageView(nil);
        [self.contentContainerView addSubview:_thumbView];
        _thumbView.backgroundColor = HOME_HAIRLINE_COLOR;
    }
    return _thumbView;
}

- (UILabel *)titleLabel
{
    if ( !_titleLabel ) {
        _titleLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_TEXT_FONT, 16),
                                    MAIN_BLACK_COLOR);
        [self.contentContainerView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)plusSymbolLabel
{
    if ( !_plusSymbolLabel ) {
        _plusSymbolLabel = AWCreateLabel(CGRectZero,
                                    @"+",
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_DIGIT_FONT, 12),
                                    MAIN_RED_COLOR);
        [self.contentContainerView addSubview:_plusSymbolLabel];
        [_plusSymbolLabel sizeToFit];
    }
    return _plusSymbolLabel;
}

- (UILabel *)earnLabel
{
    if ( !_earnLabel ) {
        _earnLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_DIGIT_FONT, 20),
                                    MAIN_RED_COLOR);
        [self.contentContainerView addSubview:_earnLabel];
    }
    return _earnLabel;
}

- (UIImageView *)locationIconView
{
    if ( !_locationIconView ) {
        _locationIconView = AWCreateImageView(nil);
        _locationIconView.frame = CGRectMake(0, 0, 10, 12);
        _locationIconView.image = [[UIImage imageNamed:@"icon_navbar_location.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _locationIconView.tintColor = HOME_WIFI_CLOSE_COLOR;
        [self.contentContainerView addSubview:_locationIconView];
    }
    return _locationIconView;
}

- (UILabel *)locationLabel
{
    if ( !_locationLabel ) {
        _locationLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_TEXT_FONT, 14),
                                    HOME_WIFI_CLOSE_COLOR);
        [self.contentContainerView addSubview:_locationLabel];
    }
    return _locationLabel;
}

- (UIView *)contentContainerView
{
    if ( !_contentContainerView ) {
        _contentContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, AWFullScreenWidth(), 0)];
        _contentContainerView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_contentContainerView];
    }
    return _contentContainerView;
}

@end
