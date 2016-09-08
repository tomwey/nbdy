//
//  EarnDetailCell.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "EarnDetailCell.h"
#import "Defines.h"

@interface EarnDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *earnLabel;

@end

@implementation EarnDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)configData:(id)data
{
    self.titleLabel.text = [data valueForKey:@"title"];
    self.timeLabel.text = [data valueForKey:@"time"];
    self.earnLabel.text = [[data valueForKey:@"earn"] description];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(15, 10, 188, 34);
    
    self.timeLabel.frame  = self.titleLabel.frame;
    self.timeLabel.top = self.titleLabel.bottom;
    
    self.earnLabel.frame = CGRectMake(0, 0, 188, 34);
    self.earnLabel.position = CGPointMake(self.width - 15 - self.earnLabel.width,
                                          self.height / 2 - self.earnLabel.height / 2);
}

- (UILabel *)titleLabel
{
    if ( !_titleLabel ) {
        _titleLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_TEXT_FONT,
                                                 16),
                                    MAIN_BLACK_COLOR);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if ( !_timeLabel ) {
        _timeLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentLeft,
                                    AWCustomFont(MAIN_DIGIT_FONT,
                                                 14),
                                    HOME_WIFI_CLOSE_COLOR);
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)earnLabel
{
    if ( !_earnLabel ) {
        _earnLabel = AWCreateLabel(CGRectZero,
                                    nil,
                                    NSTextAlignmentRight,
                                    AWCustomFont(MAIN_DIGIT_FONT,
                                                 20),
                                    MAIN_RED_COLOR);
        [self.contentView addSubview:_earnLabel];
    }
    return _earnLabel;
}

@end
