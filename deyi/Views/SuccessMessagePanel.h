//
//  SuccessMessagePanel.h
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "MessagePanel.h"

@interface SuccessMessagePanel : MessagePanel

+ (MessagePanel *)showWithTitle:(NSString *)title taskName:(NSString *)taskName earn:(NSInteger)earn;

@end
