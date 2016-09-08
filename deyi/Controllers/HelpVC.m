//
//  HelpVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "HelpVC.h"
#import "Defines.h"

@implementation HelpVC

- (NSString *)contentUrl
{
    return [NSString stringWithFormat:@"%@/p/help", SERVER_HOST];
}

@end
