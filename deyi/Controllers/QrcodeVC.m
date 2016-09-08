//
//  QrcodeVC.m
//  deyi
//
//  Created by tangwei1 on 16/9/8.
//  Copyright © 2016年 tangwei1. All rights reserved.
//

#import "QrcodeVC.h"
#import "Defines.h"

@interface QrcodeVC ()

@property (nonatomic, strong) UIImageView *qrcodeView;

@end
@implementation QrcodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"扫描二维码";
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.qrcodeView = AWCreateImageView(nil);
    self.qrcodeView.frame = CGRectMake(0, 0, self.contentView.width * 0.618,
                                 self.contentView.width * 0.618);
    self.qrcodeView.center = CGPointMake(self.contentView.width / 2, self.contentView.height / 2);
    
    [self.contentView addSubview:self.qrcodeView];
    
    self.qrcodeView.backgroundColor = HOME_WIFI_CLOSE_COLOR;
    
    [self startLoadQRCode];
}

- (void)startLoadQRCode
{
    __weak typeof(self) me = self;
    [self startLoading:^{
        [me startLoadQRCode];
    }];
    
    NSURL *imageURL = [NSURL URLWithString:[[UserService sharedInstance] currentUser].qrcodeUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:imageURL];
    [self.qrcodeView setImageWithURLRequest:request
                           placeholderImage:nil
                                    success:^(NSURLRequest * _Nonnull request,
                                              NSHTTPURLResponse * _Nullable response,
                                              UIImage * _Nonnull image) {
                                        //
                                        me.qrcodeView.image = image;
                                        [me finishLoading:LoadingStateSuccessResult];
                                    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                                        //
                                        [me finishLoading:LoadingStateFail];
                                    }];
}

@end
