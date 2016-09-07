//
//  ShareDetailVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/7.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "ShareDetailVC.h"
#import "Defines.h"

@interface ShareDetailVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton  *shareButton;

@end

@implementation ShareDetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.params[@"item"][@"title"];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    
    self.webView.delegate = self;
    
    [self loadWebView];
    
    // 分享按钮
    self.shareButton = AWCreateTextButton(CGRectMake(0, 0, self.contentView.width * 0.8, 44),
                                               @"立即分享到朋友圈",
                                               [UIColor whiteColor],
                                               self,
                                               @selector(shareFriend));
    [self.contentView addSubview:self.shareButton];
    
    self.shareButton.backgroundColor = MAIN_RED_COLOR;
    self.shareButton.cornerRadius = 8;
    self.shareButton.clipsToBounds = YES;
    
    self.shareButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    self.shareButton.center = CGPointMake(self.contentView.width / 2,
                                     self.contentView.height - 10 - self.shareButton.height / 2);
    
    self.shareButton.hidden = YES;
}

- (void)shareFriend
{
    
}

- (void)loadWebView
{
    self.shareButton.hidden = YES;
    
    NSURL *url = [NSURL URLWithString:self.contentUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (NSString *)contentUrl
{
    return self.params[@"item"][@"link"];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    __weak typeof(self) me = self;
    [self startLoading:^{
        [me loadWebView];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.shareButton.hidden = NO;
    [self finishLoading:LoadingStateSuccessResult];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    [self finishLoading:LoadingStateFail];
}

@end
