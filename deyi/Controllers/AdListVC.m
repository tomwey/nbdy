//
//  AdListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AdListVC.h"
#import "Defines.h"
#import "AdCell.h"

@implementation AdListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"广告任务";
    
    [self.tableView removeBlankCells];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.rowHeight = [AdCell cellHeight] + 20;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, -20, 0);
}

/** api名字 */
- (NSString *)apiName
{
    return API_V1_AD_LIST;
}

/** api参数，不包括分页参数 */
- (NSDictionary *)apiParams
{
    return @{ @"loc" : [[AWLocationManager sharedInstance] formatedCurrentLocation_1] };
}

/** 返回一个数据源 */
- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"AdCell", @"cell.id");
}

/** 某个cell或者某个grid被选中的回调方法，之类可以重写该方法 */
- (void)didSelectItem:(id)item
{
    
}

@end
