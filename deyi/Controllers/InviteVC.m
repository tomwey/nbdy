//
//  InviteVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/6.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "InviteVC.h"
#import "Defines.h"

@interface InviteVC () <UIWebViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton  *shareButton;

@end

@implementation InviteVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.title = self.params[@"item"][@"title"];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.frame = self.contentView.bounds;
    [self.contentView addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    
    self.webView.delegate = self;
    
    [self loadWebView];
    
    // 分享按钮
    self.shareButton = AWCreateTextButton(CGRectMake(0, 0, self.contentView.width * 0.8, 44),
                                          @"立即分享收徒",
                                          [UIColor whiteColor],
                                          self,
                                          @selector(shareToInvite));
    [self.contentView addSubview:self.shareButton];
    
    self.shareButton.backgroundColor = MAIN_RED_COLOR;
    self.shareButton.cornerRadius = 8;
    self.shareButton.clipsToBounds = YES;
    
    self.shareButton.titleLabel.font = AWCustomFont(MAIN_TEXT_FONT, 16);
    
    self.shareButton.center = CGPointMake(self.contentView.width / 2,
                                          self.contentView.height - 10 - self.shareButton.height / 2);
    
    self.shareButton.hidden = YES;
}

- (void)shareToInvite
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"分享收徒"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"分享朋友圈", @"扫码收徒", @"复制邀请链接", nil];
    [actionSheet showInView:self.contentView];
}

- (void)shareFriend
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index: %d", buttonIndex);
    switch (buttonIndex) {
        case 0:
        {
            [self shareFriend];
        }
            break;
        case 1:
        {
            [self showQrcode];
        }
            break;
        case 2:
        {
            [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@/shoutu?uid=%@",
                                                       SERVER_HOST, [[UserService sharedInstance] currentUser].uid];
            [[[UIAlertView alloc] initWithTitle:@"提示"
                                        message:@"复制成功"
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"确定", nil] show];
        }
            break;
            
        default:
            break;
    }
}

- (void)showQrcode
{
    UIViewController *vc = [[AWMediator sharedInstance] openVCWithName:@"QrcodeVC" params:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadWebView
{
    self.shareButton.hidden = YES;
    
    NSURL *url = [NSURL URLWithString:self.contentUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
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

- (NSString *)contentUrl
{
    return [NSString stringWithFormat:@"%@/shoutu/info?uid=%@", SERVER_HOST,
            [[UserService sharedInstance] currentUser].uid];
}

@end
