//
//  ModuleService.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ModuleService.h"
#import "Module.h"

@implementation ModuleService

- (NSArray *)loadModules
{
    NSArray *modules = @[@{
                             @"name" : @"联盟任务",
                             @"icon" : @"icon_home_channel.png",
                             @"pageClassName" : @"ChannelListVC",
                             },
                         @{
                             @"name" : @"分享任务",
                             @"icon" : @"icon_home_share.png",
                             @"pageClassName" : @"ShareListVC",
                             },
                         @{
                             @"name" : @"广告任务",
                             @"icon" : @"icon_home_ad.png",
                             @"pageClassName" : @"AdListVC",
                             },
                         @{
                             @"name" : @"收徒任务",
                             @"icon" : @"icon_home_invite.png",
                             @"pageClassName" : @"InviteVC",
                             },
                         @{
                             @"name" : @"收益明细",
                             @"icon" : @"icon_home_earn.png",
                             @"pageClassName" : @"EarnVC",
                             },
                         @{
                             @"name" : @"益豆商城",
                             @"icon" : @"icon_home_shop.png",
                             @"pageClassName" : @"ShopVC",
                             },
                         @{
                             @"name" : @"同城租房",
                             @"icon" : @"icon_home_rent.png",
                             @"pageClassName" : @"RentVC",
                             },
                         @{
                             @"name" : @"新手攻略",
                             @"icon" : @"icon_home_help.png",
                             @"pageClassName" : @"HelpVC",
                             },
                         @{
                             @"name" : @"每日签到",
                             @"icon" : @"icon_home_checkin.png",
                             @"pageClassName" : @"",
                             }];
    
    NSMutableArray *temp = [NSMutableArray array];
    for (id dict in modules) {
        Module *m = [[Module alloc] initWithName:dict[@"name"]
                                            icon:dict[@"icon"]
                                   pageClassName:dict[@"pageClassName"]];
        [temp addObject:m];
    }
    return temp;
}

@end
