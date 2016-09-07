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
//    [self.dataService POST:API_V1_AD_VIEW params:<#(NSDictionary *)#> completion:<#^(id result, NSError *error)completion#>]
}

- (NetworkService *)dataService
{
    if ( !_dataService ) {
        _dataService = [[NetworkService alloc] init];
    }
    return _dataService;
}

@end
