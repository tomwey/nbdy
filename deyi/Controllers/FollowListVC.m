//
//  FollowListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "FollowListVC.h"
#import "Defines.h"

@implementation FollowListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"关注公众号";
    
    self.tableView.rowHeight = 90;
}

- (NSString *)apiName
{
    return API_V1_FOLLOW_LIST;
}

- (NSDictionary *)apiParams
{
    return @{ @"token": [[UserService sharedInstance] currentUserAuthToken] };
}

- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"FollowCell", @"cell.id");
}

@end
