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
    
    self.tableView.rowHeight = 100;
    
    // 设置分割线
    [self.tableView removeCompatibility];
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

- (void)didSelectItem:(id)item
{
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"WebViewVC"
                                                                params:@{ @"link" : [item valueForKey:@"link"] ?: @"" }];
    vc.title = [NSString stringWithFormat:@"关注%@", [item valueForKey:@"gzh_name"]];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
