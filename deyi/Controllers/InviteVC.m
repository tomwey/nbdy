//
//  InviteVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "InviteVC.h"
#import "Defines.h"

@implementation InviteVC

- (NSString *)contentUrl
{
    return [NSString stringWithFormat:@"%@/shoutu/info?uid=%@", SERVER_HOST,
            [[UserService sharedInstance] currentUser].uid];
}

@end
