//
//  AdHTMLDetailVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "AdHTMLDetailVC.h"
#import "Defines.h"

@interface AdHTMLDetailVC ()

@property (nonatomic, strong) NetworkService *dataService;

@end
@implementation AdHTMLDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.params[@"item"][@"title"];
    
}

- (NSString *)contentUrl
{
    return self.params[@"item"][@"ad_link"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self finishLoading:LoadingStateSuccessResult];
    
    NSMutableDictionary *params = [APIDeviceParams() mutableCopy];
    [params setObject:[[UserService sharedInstance] currentUserAuthToken] forKey:@"token"];
    [params setObject:self.params[@"item"][@"id"] ?: @"0" forKey:@"ad_id"];
    [params setObject:[[AWLocationManager sharedInstance] formatedCurrentLocation_1] forKey:@"loc"];
    
    [self.dataService POST:API_V1_AD_VIEW params:params completion:^(id result, NSError *error) {
        if ( !error ) {
            NSLog(@"成功浏览广告");
        } else {
            NSLog(@"失败浏览广告");
        }
    }];
}

- (NetworkService *)dataService
{
    if ( !_dataService ) {
        _dataService = [[NetworkService alloc] init];
    }
    return _dataService;
}

@end
