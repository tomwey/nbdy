//
//  DataListVC.h
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "BaseNavBarVC.h"
#import "AWTableViewDataSource.h"

@interface DataListVC : BaseNavBarVC <UITableViewDelegate>

@property (nonatomic, strong, readonly) UITableView *tableView;

/** api名字 */
- (NSString *)apiName;

/** api参数，不包括分页参数 */
- (NSDictionary *)apiParams;

/** 返回一个数据源 */
- (AWTableViewDataSource *)tableDataSource;

/** 是否需要分页加载 */
- (BOOL)needPaginate;

@end
