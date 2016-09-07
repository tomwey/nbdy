//
//  ShareCell.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ShareCell.h"
#import "Defines.h"

@interface ShareCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel     *titleLabel;
@property (nonatomic, strong) UILabel     *totalEarnLabel;
@property (nonatomic, strong) UILabel     *firstOpenEarnLabel;
@property (nonatomic, strong) UILabel     *leftCountLabel;
@property (nonatomic, strong) UILabel     *shareTipLabel;

@property (nonatomic, strong) UIView      *verticalLine;

@end

@implementation ShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configData:(id)data
{
    NSURL *iconURL = [NSURL URLWithString:[data valueForKey:@"icon"]];
    [self.iconView setImageWithURL:iconURL];
    
    self.titleLabel.text = [data valueForKey:@"title"];
    
    // 总奖励
    NSString *earn = [NSString stringWithFormat:@"总奖励 %@", [data valueForKey:@"income"]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:earn];
    
    [string setAttributes:@{ NSFontAttributeName: AWCustomFont(MAIN_DIGIT_FONT, 16),
                             NSForegroundColorAttributeName: MAIN_RED_COLOR}
                    range:NSMakeRange(4, earn.length - 4)];
    self.totalEarnLabel.attributedText = string;
    [self.totalEarnLabel sizeToFit];
    
    // 首次打开奖励
    earn = [NSString stringWithFormat:@"( 好友首次打开奖励 %@ )", [data valueForKey:@"first_open_income"]];
    string = [[NSMutableAttributedString alloc] initWithString:earn];
    
    [string setAttributes:@{ NSFontAttributeName: AWCustomFont(MAIN_DIGIT_FONT, 16),
                             NSForegroundColorAttributeName: MAIN_RED_COLOR}
                    range:NSMakeRange(10, earn.length - 1 - 10)];
    self.firstOpenEarnLabel.attributedText = string;
    [self.firstOpenEarnLabel sizeToFit];
    
    // 剩余任务数
    self.leftCountLabel.text = [NSString stringWithFormat:@"剩余次数：%@", [data valueForKey:@"left_count"]];
    
    // 分享提示
    self.shareTipLabel.text = @"分享朋友圈";
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.position = CGPointMake(15, 10);
    
    CGFloat width = self.width - self.iconView.right - 15 - 15;
    self.titleLabel.frame = CGRectMake(self.iconView.right + 15,
                                       self.iconView.top - 5,
                                       width, 34);
    
    self.totalEarnLabel.left = self.titleLabel.left;
    self.totalEarnLabel.top = self.iconView.bottom - self.totalEarnLabel.height;
    
    self.firstOpenEarnLabel.left = self.totalEarnLabel.right;
    self.firstOpenEarnLabel.top = self.totalEarnLabel.bottom - self.firstOpenEarnLabel.height;
    
    self.verticalLine.frame = CGRectMake(self.iconView.left,
                                         self.iconView.bottom + 10,
                                         self.width - self.iconView.left,
                                         1);
    [[self.verticalLine viewWithTag:10001] setFrame:CGRectMake(-1, 0, self.verticalLine.width + 1, 1)];
    
    self.leftCountLabel.frame = CGRectMake(self.iconView.left,
                                           self.verticalLine.bottom + 5,
                                           self.width - self.iconView.left,
                                           30);
    self.shareTipLabel.frame = CGRectMake(self.width - self.iconView.left - 128, self.leftCountLabel.top, 128, 30);
    
}

- (UIImageView *)iconView
{
    if ( !_iconView ) {
        _iconView = AWCreateImageView(nil);
        [self.contentView addSubview:_iconView];
        _iconView.backgroundColor = HOME_HAIRLINE_COLOR;
        _iconView.frame = CGRectMake(0, 0, 64, 64);
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if ( !_titleLabel ) {
        _titleLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 15),
                                   MAIN_BLACK_COLOR);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)totalEarnLabel
{
    if ( !_totalEarnLabel ) {
        _totalEarnLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_TEXT_FONT, 14),
                                    MAIN_BLACK_COLOR);
        [self.contentView addSubview:_totalEarnLabel];
    }
    return _totalEarnLabel;
}

- (UILabel *)firstOpenEarnLabel
{
    if ( !_firstOpenEarnLabel ) {
        _firstOpenEarnLabel = AWCreateLabel(CGRectZero,
                                        nil,
                                        NSTextAlignmentLeft,
                                        AWCustomFont(MAIN_TEXT_FONT, 14),
                                        SETTINGS_GRAY_COLOR);
        [self.contentView addSubview:_firstOpenEarnLabel];
    }
    return _firstOpenEarnLabel;
}

- (UILabel *)leftCountLabel
{
    if ( !_leftCountLabel ) {
        _leftCountLabel = AWCreateLabel(CGRectZero,
                                        nil,
                                        NSTextAlignmentLeft,
                                        AWCustomFont(MAIN_TEXT_FONT, 14),
                                        HOME_WIFI_CLOSE_COLOR);
        [self.contentView addSubview:_leftCountLabel];
    }
    return _leftCountLabel;
}

- (UILabel *)shareTipLabel
{
    if ( !_shareTipLabel ) {
        _shareTipLabel = AWCreateLabel(CGRectZero,
                                        nil,
                                        NSTextAlignmentRight,
                                        AWCustomFont(MAIN_TEXT_FONT, 14),
                                        HOME_WIFI_CLOSE_COLOR);
        [self.contentView addSubview:_shareTipLabel];
    }
    return _shareTipLabel;
}

- (UIView *)verticalLine
{
    if ( !_verticalLine ) {
        _verticalLine = [[UIView alloc] init];
        
        AWHairlineView *lineView = [[AWHairlineView alloc] initWithLineColor:AWColorFromRGB(201, 201, 201)];
        [_verticalLine addSubview:lineView];
        lineView.tag = 10001;
        
        _verticalLine.clipsToBounds = YES;
        
        [self.contentView addSubview:_verticalLine];
    }
    return _verticalLine;
}

@end
