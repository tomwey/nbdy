//
//  FailureMessagePanel.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "FailureMessagePanel.h"
#import "Defines.h"

@interface FailureMessagePanel ()

@property (nonatomic, strong) UILabel *errorMessageLabel;

@end

@implementation FailureMessagePanel

+ (MessagePanel *)showWithTitle:(NSString *)title
                        message:(NSString *)errorMessage
              footerButtonTitle:(NSString *)buttonTitle
{
    FailureMessagePanel *panel = [FailureMessagePanel showInView:nil];
    panel.title = title;
    panel.footerButtonTitle = buttonTitle;
    
    panel.errorMessageLabel.text = errorMessage;
    
    return panel;
}

- (void)layoutSubviews
{
    self.errorMessageLabel.frame = CGRectMake(0, 0,
                                             self.bodyView.width * 0.8,
                                             30);
    CGRect textBounds = [self.errorMessageLabel.text boundingRectWithSize:
                         CGSizeMake(self.errorMessageLabel.width,1000)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:
                         @{ NSFontAttributeName: self.errorMessageLabel.font }
                                                                 context:NULL];
    self.errorMessageLabel.height = textBounds.size.height;
    self.errorMessageLabel.center = CGPointMake(self.bodyView.width / 2, 15 + self.errorMessageLabel.height / 2);
    
    self.bodyView.height = self.errorMessageLabel.bottom + 10;
    
    [super layoutSubviews];
}

- (UILabel *)errorMessageLabel
{
    if ( !_errorMessageLabel ) {
        _errorMessageLabel = AWCreateLabel(CGRectZero,
                                          nil,
                                          NSTextAlignmentCenter,
                                          AWCustomFont(MAIN_TEXT_FONT, 16),
                                          MAIN_RED_COLOR);
        _errorMessageLabel.numberOfLines = 0;
        [self.bodyView addSubview:_errorMessageLabel];
    }
    return _errorMessageLabel;
}

@end
