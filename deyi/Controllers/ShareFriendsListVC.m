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
    
    self.tableView.rowHeight = 124;
    
    // 设置分割线
    [self.tableView removeCompatibility];
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

- (void)didSelectItem:(id)item
{
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"ShareDetailVC"
                                                                params:@{ @"item" : item ?: @{} }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
