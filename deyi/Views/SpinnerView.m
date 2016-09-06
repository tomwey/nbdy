//
//  SpinnerView.m
//  deyi
//
//  Created by tomwey on 9/4/16.
//  Copyright © 2016 tangwei1. All rights reserved.
//

#import "SpinnerView.h"
#import "Defines.h"

@interface SpinnerView ()

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *loadingView;

@end

@implementation SpinnerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame] ) {
        
        self.frame = AWFullScreenBounds();
        
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.25;
        [self addSubview:self.maskView];
        
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 88, 88)];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        
        [self addSubview:self.contentView];
        
        self.contentView.center = CGPointMake(self.width / 2, self.height / 2);
        
        self.loadingView = AWCreateImageView(nil);
        self.loadingView.frame = CGRectMake(0, 0, self.contentView.width * 0.58, self.contentView.width * 0.58 * 0.83);
        [self.contentView addSubview:self.loadingView];
        
        self.loadingView.center = CGPointMake(self.contentView.width / 2, self.contentView.height / 2);
        
        self.loadingView.animationImages = @[
                                             [UIImage imageNamed:@"loading_1.png"],
                                             [UIImage imageNamed:@"loading_2.png"],
                                             [UIImage imageNamed:@"loading_3.png"],
                                             [UIImage imageNamed:@"loading_4.png"],
                                             ];
        self.loadingView.animationDuration = 0.8;
    }
    return self;
}

+ (void)showSpinnerInView:(UIView *)parent
{
    UIView *superView = parent ?: AWAppWindow();
    
    SpinnerView *spinnerView = [[SpinnerView alloc] init];
    [superView addSubview:spinnerView];
    spinnerView.tag = 1010112;
    spinnerView.center = CGPointMake(superView.width / 2, superView.height / 2);
    
    [superView bringSubviewToFront:spinnerView];
    
    spinnerView.maskView.alpha = 0.0;
    [UIView animateWithDuration:.25 animations:^{
        spinnerView.maskView.alpha = 0.25;
    }];
    
    if ( [spinnerView.loadingView isAnimating] == NO ) {
        [spinnerView.loadingView startAnimating];
    }
}

+ (void)hideSpinnerForView:(UIView *)parent
{
    UIView *superView = parent ?: AWAppWindow();
    
    SpinnerView *spinner = [superView viewWithTag:1010112];
    
    [spinner.loadingView stopAnimating];
    
    [spinner removeFromSuperview];
}

@end
