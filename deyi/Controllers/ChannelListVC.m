//
//  ChannelListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ChannelListVC.h"
#import "Defines.h"

@interface ChannelListVC ()

@end

@implementation ChannelListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;

}

- (NSString *)apiName
{
    return API_V1_CHANNELS_LIST;
}

- (NSDictionary *)apiParams
{
    return @{ @"os_type" : @(1) };
}

- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"ChannelCell", @"cell.id");
}

@end
