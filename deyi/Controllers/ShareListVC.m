//
//  ShareListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ShareListVC.h"
#import "Defines.h"

@interface ShareListVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong, readwrite) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ShareListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = @[@"关注任务", @"分享任务"];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    self.tableView.backgroundColor = self.contentView.backgroundColor;
    
    // 移除多余的空行
    [self.tableView removeBlankCells];
    
    [self.tableView removeCompatibility];
    
    // 默认设置表视图的行高为50
    self.tableView.rowHeight = 50;
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
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
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.textLabel.font = AWCustomFont(MAIN_TEXT_FONT, 14);
    cell.textLabel.textColor = MAIN_RED_COLOR;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *name = indexPath.row == 0 ? @"FollowListVC" : @"ShareFriendsListVC";
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:name params:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
