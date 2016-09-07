//
//  FollowCell.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "FollowCell.h"
#import "Defines.h"

@interface FollowCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UILabel *earnLabel;
@property (nonatomic, strong) UILabel *noteLabel;

@end

@implementation FollowCell

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
    
    self.nameLabel.text = [data valueForKey:@"gzh_name"];
    self.introLabel.text = [data valueForKey:@"gzh_intro"];
    
    NSString *earn = [NSString stringWithFormat:@"关注奖励 %@", [data valueForKey:@"income"]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:earn];
    
    [string setAttributes:@{ NSFontAttributeName: AWCustomFont(MAIN_DIGIT_FONT, 16),
                             NSForegroundColorAttributeName: MAIN_RED_COLOR}
                    range:NSMakeRange(5, earn.length - 5)];
    self.earnLabel.attributedText = string;
    [self.earnLabel sizeToFit];
    
    self.noteLabel.text = [NSString stringWithFormat:@"(%@)", [data valueForKey:@"note"] ?: @"7天内不能取消关注"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.iconView.center = CGPointMake(15 + self.iconView.width / 2, self.height / 2);
    
    self.nameLabel.frame = CGRectMake(self.iconView.right + 10,
                                      self.iconView.top - 5,
                                      self.width - self.iconView.right - 10 - 15, 30);
    
    self.introLabel.frame = self.nameLabel.frame;
    self.introLabel.height = 20;
    self.introLabel.top = self.nameLabel.bottom;
    
//    self.earnLabel.frame = self.nameLabel.frame;
    self.earnLabel.left = self.nameLabel.left;
    self.earnLabel.top = self.introLabel.bottom + 5;
    self.earnLabel.height = 20;
    
    self.noteLabel.frame = CGRectMake(self.earnLabel.right + 3,
                                      self.earnLabel.top,
                                      self.nameLabel.width - self.earnLabel.width - 3,
                                      20);
}

- (UIImageView *)iconView
{
    if ( !_iconView ) {
        _iconView = AWCreateImageView(nil);
        [self.contentView addSubview:_iconView];
        _iconView.backgroundColor = HOME_HAIRLINE_COLOR;
        _iconView.frame = CGRectMake(0, 0, 70, 70);
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if ( !_nameLabel ) {
        _nameLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 15),
                                   MAIN_BLACK_COLOR);
        [self.contentView addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)introLabel
{
    if ( !_introLabel ) {
        _introLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 14),
                                   SETTINGS_GRAY_COLOR);
        [self.contentView addSubview:_introLabel];
    }
    return _introLabel;
}

- (UILabel *)earnLabel
{
    if ( !_earnLabel ) {
        _earnLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 14),
                                   MAIN_BLACK_COLOR);
        [self.contentView addSubview:_earnLabel];
    }
    return _earnLabel;
}

- (UILabel *)noteLabel
{
    if ( !_noteLabel ) {
        _noteLabel = AWCreateLabel(CGRectZero,
                                   nil,
                                   NSTextAlignmentLeft,
                                   AWCustomFont(MAIN_TEXT_FONT, 13),
                                   SETTINGS_GRAY_COLOR);
        [self.contentView addSubview:_noteLabel];
    }
    return _noteLabel;
}

@end
