//
//  SuccessMessagePanel.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "SuccessMessagePanel.h"
#import "Defines.h"

@interface SuccessMessagePanel ()

@property (nonatomic, strong) UILabel *successLabel;
@property (nonatomic, strong) UILabel *taskMessageLabel;
@property (nonatomic, strong) UILabel *earnMessageLabel;

@end

@implementation SuccessMessagePanel

+ (MessagePanel *)showWithTitle:(NSString *)title taskName:(NSString *)taskName earn:(NSInteger)earn
{
    SuccessMessagePanel *panel = [SuccessMessagePanel showInView:nil];
    panel.title = title;
    panel.footerButtonTitle = @"很好，继续赚豆";
    
    NSString *text = [NSString stringWithFormat:@"完成：%@", taskName];
    panel.taskMessageLabel.text = text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:
                                                   [NSString stringWithFormat:@"+ %d", earn]];
    [attributedString addAttributes:@{ NSFontAttributeName: AWCustomFont(MAIN_DIGIT_FONT, 12) }
                              range:NSMakeRange(0, 1)];
    
    panel.earnMessageLabel.attributedText = attributedString;
    return panel;
}

- (void)layoutSubviews
{
    self.successLabel.frame = CGRectMake(0, 10, self.bodyView.width, 30);
    self.taskMessageLabel.frame = CGRectMake(0, self.successLabel.bottom,
                                             self.bodyView.width * 0.8,
                                             30);
    CGRect textBounds = [self.taskMessageLabel.text boundingRectWithSize:
                         CGSizeMake(self.taskMessageLabel.width,1000)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:
                         @{ NSFontAttributeName: self.taskMessageLabel.font }
                                                                 context:NULL];
    self.taskMessageLabel.height = textBounds.size.height;
    self.taskMessageLabel.center = CGPointMake(self.bodyView.width / 2, self.successLabel.bottom + 10 + self.taskMessageLabel.height / 2);
    
    self.earnMessageLabel.frame = CGRectMake(0, self.taskMessageLabel.bottom + 10,
                                             self.bodyView.width,
                                             34);
    
    self.bodyView.height = self.earnMessageLabel.bottom;
    
    [super layoutSubviews];
}

- (UILabel *)successLabel
{
    if ( !_successLabel ) {
        _successLabel = AWCreateLabel(CGRectZero,
                                      @"恭喜！任务完成！",
                                      NSTextAlignmentCenter,
                                      AWCustomFont(MAIN_TEXT_FONT, 14),
                                      MAIN_RED_COLOR);
        [self.bodyView addSubview:_successLabel];
    }
    return _successLabel;
}

- (UILabel *)taskMessageLabel
{
    if ( !_taskMessageLabel ) {
        _taskMessageLabel = AWCreateLabel(CGRectZero,
                                          nil,
                                          NSTextAlignmentCenter,
                                          AWCustomFont(MAIN_TEXT_FONT, 14),
                                          HOME_WIFI_CLOSE_COLOR);
        _taskMessageLabel.numberOfLines = 0;
        [self.bodyView addSubview:_taskMessageLabel];
    }
    return _taskMessageLabel;
}

- (UILabel *)earnMessageLabel
{
    if ( !_earnMessageLabel ) {
        _earnMessageLabel = AWCreateLabel(CGRectZero,
                                          nil,
                                          NSTextAlignmentCenter,
                                          AWCustomFont(MAIN_DIGIT_FONT, 20),
                                          MAIN_RED_COLOR);
        [self.bodyView addSubview:_earnMessageLabel];
    }
    return _earnMessageLabel;
}

@end
