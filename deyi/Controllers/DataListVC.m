//
//  DataListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "DataListVC.h"
#import "Defines.h"

@interface DataListVC ()

@property (nonatomic, strong, readwrite) UITableView *tableView;

@property (nonatomic, strong) NetworkService *loadDataService;

@property (nonatomic, strong) AWTableViewDataSource *inTableDataSource;

@end

@implementation DataListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    
    self.tableView.backgroundColor = self.contentView.backgroundColor;
    
    // 移除多余的空行
    [self.tableView removeBlankCells];
    
    // 默认设置表视图的行高为50
    self.tableView.rowHeight = 50;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    // 从子类获取数据源
    self.inTableDataSource = self.tableDataSource;
    
    // 将获取到的数据源设置给表视图
    self.tableView.dataSource = self.inTableDataSource;
    
    self.tableView.delegate   = self;
    
    // 当UI主线程执行完之后立即加载数据
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadDataForURI:[self apiName] params:[self apiParams]];
    });
}

- (BOOL)needPaginate
{
    return NO;
}

- (NSString *)apiName
{
    return nil;
}

- (NSDictionary *)apiParams
{
    return nil;
}

- (AWTableViewDataSource *)tableDataSource
{
    return nil;
}

- (void)loadDataForURI:(NSString *)uri params:(NSDictionary *)params
{
    if ( uri.length == 0 ) return;
    
    __weak typeof(self) me = self;
    [self startLoading:^{
        [me loadDataForURI:uri params:params];
    }];
    [self.loadDataService GET:uri params:params completion:^(id result, NSError *error) {
        if ( error ) {
            [me finishLoading:LoadingStateFail];
        } else {
            id data = result[@"data"];
            if ( [data isKindOfClass:[NSDictionary class]] ) {
                // TODO
            } else if ( [data isKindOfClass:[NSArray class]] ) {
                if ( [data count] == 0 ) {
                    [me finishLoading:LoadingStateEmptyResult];
                } else {
                    self.inTableDataSource.dataSource = data;
                    [self.tableView reloadData];
                    
                    [me finishLoading:LoadingStateSuccessResult];
                }
            }
        }
    }];
}

- (NetworkService *)loadDataService
{
    if ( !_loadDataService ) {
        _loadDataService = [[NetworkService alloc] init];
    }
    return _loadDataService;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id item = [self.inTableDataSource.dataSource objectAtIndex:indexPath.row];
    [self didSelectItem:item];
}

- (void)didSelectItem:(id)item
{
    NSLog(@"selected item: %@", item);
}

@end
