//
//  EarnVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "EarnVC.h"
#import "Defines.h"

@interface EarnVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NetworkService *loadDataService;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIView  *tableHeaderView;
@property (nonatomic, strong) UILabel *totalEarnLabel;

@end
@implementation EarnVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds
                                                  style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    
    [self.tableView removeBlankCells];
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    
    self.tableView.backgroundColor = self.contentView.backgroundColor;
    
    self.tableView.rowHeight = 50;
    
    [self loadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell.id"];
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell.id"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    UILabel *nameLabel = (UILabel *)[cell.contentView viewWithTag:1001];
    if ( !nameLabel ) {
        nameLabel = AWCreateLabel(CGRectMake(15, self.tableView.rowHeight / 2 - 34 / 2, 168, 34),
                                  nil,
                                  NSTextAlignmentLeft,
                                  AWCustomFont(MAIN_TEXT_FONT, 16),
                                  MAIN_BLACK_COLOR);
        [cell.contentView addSubview:nameLabel];
        nameLabel.tag = 1001;
    }
    
    UILabel *earnLabel = (UILabel *)[cell.contentView viewWithTag:1002];
    if ( !earnLabel ) {
        earnLabel = AWCreateLabel(CGRectMake(self.contentView.width - 15 - 15 - 218, self.tableView.rowHeight / 2 - 34 / 2, 218, 34),
                                  nil,
                                  NSTextAlignmentRight,
                                  AWCustomFont(MAIN_DIGIT_FONT, 18),
                                  MAIN_RED_COLOR);
        [cell.contentView addSubview:earnLabel];
        earnLabel.tag = 1002;
    }
    
    id obj = self.dataSource[indexPath.row];
    nameLabel.text = [obj valueForKey:@"task_name"];
    earnLabel.text = [[obj valueForKey:@"total"] description];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id obj = self.dataSource[indexPath.row];
    
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"EarnDetailVC" params:@{ @"item": obj ?: @{} }];
    vc.title = obj[@"task_name"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData
{
    __weak typeof(self) me = self;
    [self startLoading:^{
        [me loadData];
    }];
    [self.loadDataService GET:API_V1_EARNS_INFO
                       params:@{ @"token": [[UserService sharedInstance] currentUserAuthToken] }
                   completion:^(id result, NSError *error) {
                       if ( error ) {
                           [me finishLoading:LoadingStateFail];
                       } else {
                           NSDictionary *data = result[@"data"];
                           if ( [data count] == 0 ) {
                               [me finishLoading:LoadingStateEmptyResult];
                           } else {
                               self.totalEarnLabel.text = [[data valueForKey:@"total_earn"] description];
                               
                               me.dataSource = data[@"tasks"];

                               [me.tableView reloadData];
                               
                               [me finishLoading:LoadingStateSuccessResult];
                           }
                       }
                   }];
}

- (UIView *)tableHeaderView
{
    if ( !_tableHeaderView ) {
        _tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.width, 80)];
        
        UIView *contentView = [[UIView alloc] initWithFrame:_tableHeaderView.bounds];
        [_tableHeaderView addSubview:contentView];
        contentView.backgroundColor = [UIColor whiteColor];
        contentView.height = 64;
        
        UILabel *label = AWCreateLabel(CGRectMake(0, 0, 218, 34),
                                       @"我的总收益",
                                       NSTextAlignmentLeft,
                                       AWCustomFont(MAIN_TEXT_FONT, 18),
                                       MAIN_BLACK_COLOR);
        [contentView addSubview:label];
        label.position = CGPointMake(15, contentView.height / 2 - label.height / 2);
        
        [contentView addSubview:self.totalEarnLabel];
        self.totalEarnLabel.position = CGPointMake(self.contentView.width - 15 - self.totalEarnLabel.width,
                                                   contentView.height / 2 - self.totalEarnLabel.height / 2);
    }
    return _tableHeaderView;
}

- (UILabel *)totalEarnLabel
{
    if ( !_totalEarnLabel ) {
        _totalEarnLabel = AWCreateLabel(CGRectMake(0, 0, 218, 34),
                                        nil,
                                        NSTextAlignmentRight,
                                        AWCustomFont(MAIN_DIGIT_FONT, 22),
                                        MAIN_RED_COLOR);
    }
    return _totalEarnLabel;
}

- (NetworkService *)loadDataService
{
    if ( !_loadDataService ) {
        _loadDataService = [[NetworkService alloc] init];
    }
    return _loadDataService;
}

@end

