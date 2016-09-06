//
//  ChannelCell.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ChannelCell.h"
#import "Defines.h"

@interface ChannelCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *summaryLabel;

@end

@implementation ChannelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)configData:(id)data
{
    NSURL *imageURL = [NSURL URLWithString:data[@"icon"]];
    [self.iconView setImageWithURL:imageURL];
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)", data[@"name"], data[@"title"]];
    self.summaryLabel.text = data[@"subtitle"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.position = CGPointMake(15, self.height / 2 - self.iconView.height / 2);
    
    self.nameLabel.frame = CGRectMake(self.iconView.right + 10, self.iconView.midY - 34 / 2,
                                      150,
                                      34);
    
    self.summaryLabel.frame = CGRectMake(AWFullScreenWidth() - 20 - 15 - 120,
                                         self.nameLabel.top,
                                         120,34);
    
}

- (UIImageView *)iconView
{
    if ( !_iconView ) {
        _iconView = AWCreateImageView(nil);
        [self.contentView addSubview:_iconView];
        _iconView.backgroundColor = HOME_HAIRLINE_COLOR;
        _iconView.clipsToBounds = YES;
        _iconView.frame = CGRectMake(0, 0, 32, 32);
        _iconView.cornerRadius = _iconView.width / 2;
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if ( !_nameLabel ) {
        _nameLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 14),
                                   MAIN_BLACK_COLOR);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)summaryLabel
{
    if ( !_summaryLabel ) {
        _summaryLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentRight,
                                   AWCustomFont(MAIN_TEXT_FONT, 14),
                                   SETTINGS_GRAY_COLOR);
        [self.contentView addSubview:_summaryLabel];
    }
    return _summaryLabel;
}

@end
