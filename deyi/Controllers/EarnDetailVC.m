//
//  EarnDetailVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "EarnDetailVC.h"
#import "Defines.h"

@implementation EarnDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 84;
    
    [self.tableView removeBlankCells];
}

- (NSString *)apiName
{
    return API_V1_EARN_DETAIL;
}

- (NSDictionary *)apiParams
{
    return @{
             @"token": [[UserService sharedInstance] currentUserAuthToken],
             @"type": self.params[@"item"][@"task_type"]
             };
}

- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"EarnDetailCell", @"cell.id");
}

@end
