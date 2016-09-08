//
//  FailureMessagePanel.h
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "MessagePanel.h"

@interface FailureMessagePanel : MessagePanel

+ (MessagePanel *)showWithTitle:(NSString *)title
                        message:(NSString *)errorMessage
              footerButtonTitle:(NSString *)buttonTitle;

@end
