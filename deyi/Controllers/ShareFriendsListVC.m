//
//  ShareFriendsListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ShareFriendsListVC.h"
#import "Defines.h"

@implementation ShareFriendsListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"分享朋友圈";
    
    self.tableView.rowHeight = 88;
}

- (NSString *)apiName
{
    return API_V1_SHARE_LIST;
}

- (NSDictionary *)apiParams
{
    return @{ @"token": [[UserService sharedInstance] currentUserAuthToken] };
}

- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"ShareCell", @"cell.id");
}

@end
