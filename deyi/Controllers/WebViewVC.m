//
//  WebViewVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/2.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "WebViewVC.h"
#import "Defines.h"

@interface WebViewVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end
@implementation WebViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.webView];
    
    self.webView.scalesPageToFit = YES;
    
    self.webView.delegate = self;
    
    [self loadWebView];
}

- (void)loadWebView
{
    NSURL *url = [NSURL URLWithString:self.params[@"link"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self startLoading:^{
        [self loadWebView];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self finishLoading:LoadingStateSuccessResult];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self finishLoading:LoadingStateFail];
}

@end
