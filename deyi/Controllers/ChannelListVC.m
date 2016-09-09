//
//  ChannelListVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ChannelListVC.h"
#import "Defines.h"
#import "DQUOperationApp.h"

@interface ChannelListVC ()

@property (nonatomic, strong) DQUOperationApp *qumiApp;

@end

@implementation ChannelListVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60;

    DR_INIT(DIANRU_APPKEY, NO, [[[UserService sharedInstance] currentUser] uid]);
}

- (NSString *)apiName
{
    return API_V1_CHANNELS_LIST;
}

- (NSDictionary *)apiParams
{
    return @{ @"os_type" : @(1) };
}

- (AWTableViewDataSource *)tableDataSource
{
    return AWTableViewDataSourceCreate(nil, @"ChannelCell", @"cell.id");
}

- (void)didSelectItem:(id)item
{
    NSLog(@"item: %@", item);
    if ( [[item valueForKey:@"name"] isEqualToString:@"趣米"] ) {
        [self.qumiApp presentQmRecommendApp:self];
    } else if ( [[item valueForKey:@"name"] isEqualToString:@"万普"] ) {
        
    } else if ( [[item valueForKey:@"name"] isEqualToString:@"有米"] ) {
        
    } else if ( [[item valueForKey:@"name"] isEqualToString:@"点乐"] ) {
        
    } else if ( [[item valueForKey:@"name"] isEqualToString:@"点入"] ) {
        DR_SHOW(DR_OFFERWALL, self, nil);
    }
}

- (DQUOperationApp *)qumiApp
{
    if ( !_qumiApp ) {
        _qumiApp = [[DQUOperationApp alloc] initwithQMPointUserID:[[UserService sharedInstance] currentUser].uid];
        _qumiApp.qmisHiddenStatusBar = NO;
        [_qumiApp qmAutoGetPoints: NO];
//        _qumiApp.delegate = self;
    }
    return _qumiApp;
}


@end
